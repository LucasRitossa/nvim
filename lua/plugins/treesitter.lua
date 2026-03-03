return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            ensure_installed = {
                "bash",
                "c",
                "css",
                "diff",
                "html",
                "java",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            auto_install = true,
            sync_install = false,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
