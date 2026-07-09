return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
        keys = {
            { "<leader>pp", "<cmd>Telescope builtin<CR>", desc = "Telescope builtin" },
            { "<leader>r", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
            { "<leader>bb", "<cmd>Telescope buffers<CR>", desc = "Find buffer" },
            { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search in buffer" },
            { "<leader>'", "<cmd>Telescope marks<CR>", desc = "Bookmarks" },
            { "<leader>f", "<cmd>Telescope git_files<CR>", desc = "Git files" },
            { "<leader>F", "<cmd>Telescope find_files<CR>", desc = "All files" },
            { "<leader>rg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
            { "<leader>CS", "<cmd>Telescope colorscheme<CR>", desc = "Color scheme" },
            { "<leader>pj", "<cmd>Telescope projects<CR>", desc = "Projects" },
        },
        opts = {
            defaults = {
                layout_config = {
                    flex = {
                        flip_columns = 110,
                    },
                    vertical = {
                        height = 0.99,
                        width = 0.99,
                    },
                    horizontal = {
                        height = 0.99,
                        width = 0.99,
                        preview_cutoff = 0,
                        preview_width = 0.5,
                    },
                },
                file_ignore_patterns = { "node_modules", ".git/", ".pnpm" },
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                    },
                },
            },
            pickers = {
                find_files = {
                    layout_strategy = "flex",
                },
                git_files = {
                    layout_strategy = "flex",
                },
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)

            -- Load extensions
            pcall(telescope.load_extension, "fzf")
            pcall(telescope.load_extension, "projects")
        end,
    },

    -- Project management
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        config = function()
            require("project_nvim").setup({
                detection_methods = { "lsp", "pattern" },
                patterns = { ".git", "Makefile", "package.json", "Cargo.toml" },
            })
        end,
    },
}
