require("dapui").setup()
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
    vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
    return
end
local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local path_to_lsp_server = jdtls_path .. "/config_mac"
local path_to_plugins = jdtls_path .. "/plugins/"
local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
    return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
os.execute("mkdir " .. workspace_dir)

-- Main Config
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        '/Users/Lucas.Ritossa/.sdkman/candidates/java/19.0.2-open/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        --'-javaagent:' .. lombok_path,
        '-Xms3g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', path_to_jar,
        '-configuration', path_to_lsp_server,
        '-data', workspace_dir,
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            home = '/Users/Lucas.Ritossa/.sdkman/candidates/java/19.0.2-open/',
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/Users/Lucas.Ritossa/.sdkman/candidates/java/17.0.5-oracle",
                    },
                    {
                        name = "JavaSE-11",
                        path = "/Users/Lucas.Ritossa/.sdkman/candidates/java/11.0.17-amzn",
                    }
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                --                 settings = {
                --                     url = vim.fn.stdpath "config" .. "/formatting-templates/intellij-java-google-style.xml",
                --                     profile = "GoogleStyle_SK",
                --                 },
            },

        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
            importOrder = {
                "java",
                "javax",
                "com",
                "org"
            },
        },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },

    flags = {
        allow_incremental_sync = true,
    },
}

config['init_options'] = {
    bundles = {
        vim.fn.glob("/Users/Lucas.Ritossa/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
            , 1)
    };
}


config['on_attach'] = function(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    --     require "lsp_signature".on_attach({
    --         bind = true, -- This is mandatory, otherwise border config won't get registered.
    --         floating_window_above_cur_line = false,
    --         padding = '',
    --         handler_opts = {
    --             border = "rounded"
    --         }
    --     }, bufnr)
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

function get_spring_boot_runner(profile, debug)
    local debug_param = ""
    if debug then
        debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
    end

    local profile_param = ""
    if profile then
        profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
    end

    return 'mvn spring-boot:run ' .. profile_param .. debug_param
end

function run_spring_boot(debug)
    vim.cmd('term ' .. get_spring_boot_runner("local", debug))
end

function attach_to_debug()
    local dap = require('dap')
    dap.configurations.java = {
        {
            type = 'java';
            request = 'attach';
            name = "Attach to the process";
            hostName = 'localhost';
            port = '5005';
        },
    }
    dap.continue()
end

vim.keymap.set('n', '<leader>dc', ':lua require"dap".continue()<CR>')
vim.keymap.set('n', '<leader>do', ':lua require"dap".step_over()<CR>')
vim.keymap.set('n', '<leader>di', ':lua require"dap".step_into()<CR>')
vim.keymap.set('n', '<S-F8>', ':lua require"dap".step_out()<CR>')
vim.keymap.set('n', '<leader>da', ':lua attach_to_debug()<CR>')
vim.keymap.set("n", "<F9>", function() run_spring_boot() end)
vim.keymap.set("n", "<F10>", function() run_spring_boot(true) end)

vim.keymap.set('n', '<leader>br', ':lua require"dap".toggle_breakpoint()<CR>')
vim.keymap.set('n', '<leader>Br', ':lua require"dap".set_breakpoint(vim.fn.input("Condition: "))<CR>')
vim.keymap.set('n', '<leader>bl', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))<CR>')
vim.keymap.set('n', '<leader>dr', ':lua require"dap".repl.open()<CR>')
vim.keymap.set('n', '<leader>dui', ':lua require"dapui".toggle()<CR>')
