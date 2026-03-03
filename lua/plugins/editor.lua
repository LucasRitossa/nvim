return {
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        keys = {
            { "<leader>t", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
        },
        opts = {
            filters = {
                dotfiles = false,
            },
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                width = 30,
                preserve_window_proportions = true,
            },
            renderer = {
                root_folder_label = false,
                highlight_git = true,
                indent_markers = {
                    enable = true,
                },
                icons = {
                    glyphs = {
                        default = "󰈚",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
            },
        },
    },

    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { [[<C-\>]], "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
        },
        opts = {
            open_mapping = [[<C-\>]],
            shade_terminals = true,
            direction = "float",
            float_opts = {
                border = "curved",
            },
        },
    },

    -- Git integration
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gstatus", "Gblame", "Gpush", "Gpull" },
    },

    -- Diffview
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
        opts = {},
    },

    -- Comment toggle
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },

    -- Debug adapter
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                opts = {},
            },
        },
    },
}
