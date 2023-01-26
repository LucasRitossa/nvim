 -- add proejct-nvim
require("project_nvim").setup {}

-- add telescope
require('telescope').load_extension('projects')
require('telescope').setup {
    defaults = {
        '--ignore-file',
        '.pnpm'
    }
}
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
