local parsers = {
    "bash",
    "c",
    "css",
    "diff",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
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
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        main = "nvim-treesitter",
        opts = {},
        config = function(_, opts)
            require("nvim-treesitter").setup(opts)
            require("nvim-treesitter").install(parsers)

            local group = vim.api.nvim_create_augroup("nvim-treesitter-init", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
}
