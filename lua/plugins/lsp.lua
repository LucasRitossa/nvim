return {
    -- Mason for managing LSP servers
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {},
    },

    -- Mason-lspconfig bridge
    {
        "williamboman/mason-lspconfig.nvim",
        version = "1.*", -- Pin to v1.x until v2.x API stabilizes
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            automatic_installation = true,
        },
    },

    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- Default capabilities with nvim-cmp
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Diagnostic configuration (signs via config(), not sign_define)
            local severity = vim.diagnostic.severity
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "",
                    spacing = 0,
                },
                signs = {
                    text = {
                        [severity.ERROR] = " ",
                        [severity.WARN] = " ",
                        [severity.HINT] = "󰠠 ",
                        [severity.INFO] = " ",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                },
            })

            -- LSP keymaps (set when LSP attaches)
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, silent = true }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<leader>c", vim.lsp.buf.format, opts)
            end

            -- Use Neovim 0.11 vim.lsp.config / vim.lsp.enable (no deprecated lspconfig[] API)
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    vim.lsp.config(server_name, {
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                    vim.lsp.enable(server_name)
                end,

                ["lua_ls"] = function()
                    vim.lsp.config("lua_ls", {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    library = {
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.stdpath("config") .. "/lua"] = true,
                                    },
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    })
                    vim.lsp.enable("lua_ls")
                end,
            })
        end,
    },

    -- LSP Saga for enhanced UI
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            ui = {
                border = "rounded",
            },
            lightbulb = {
                enable = false,
            },
            symbol_in_winbar = {
                enable = false,
            },
        },
        keys = {
            { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover documentation" },
            { "gn", "<cmd>Lspsaga rename<CR>", desc = "Rename symbol" },
            { "gca", "<cmd>Lspsaga code_action<CR>", desc = "Code action" },
            { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous diagnostic" },
            { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic" },
        },
    },
}
