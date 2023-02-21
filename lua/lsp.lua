require("project_nvim").setup {}

-- add telescope
require('telescope').load_extension('projects')
require('telescope').setup({
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
                preview_width = 0.5
            }
        },
        '--ignore-file',
        '.pnpm'
    },
    pickers = {
        find_files = {
            layout_strategy = "flex"
        },
        git_files = {
            layout_strategy = "flex"
        }
    },
})
-- add nvim-tree support
require 'nvim-tree'.setup {}

-- add mason support and import all languages
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup {}
    end,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
        prefix = "",
        spacing = 0,
    },
    signs = true,
    underline = true,
}
)

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}

-- -- Hover UI
-- require("hover").setup{ init = function() require("hover.providers.lsp")
--     require('hover.providers.gh')
--     require('hover.providers.gh_user')
--     require('hover.providers.man')
--     require('hover.providers.dictionary')
-- end,
-- }
-- vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
-- vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
