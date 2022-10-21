require 'nvim-treesitter.configs'.setup {
    sync_install = false,
    highlight = { -- enable highlighting for all file types
        enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    },
}
