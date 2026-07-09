return {
    -- Mason for managing LSP servers
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {},
    },

    -- LSP Configuration (load before mason-lspconfig so vim.lsp.config is set first)
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
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
            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, silent = true }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<leader>c", vim.lsp.buf.format, opts)
            end

            -- Neovim 0.11+ native LSP config (replaces require("lspconfig")[...].setup)
            vim.lsp.config("*", {
                capabilities = capabilities,
                on_attach = on_attach,
            })

            vim.lsp.config("lua_ls", {
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
        end,
    },

    -- Mason-lspconfig bridge (v2: auto-enables installed servers via vim.lsp.enable)
    {
        "williamboman/mason-lspconfig.nvim",
        version = "^2.0.0",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            automatic_enable = true,
        },
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
