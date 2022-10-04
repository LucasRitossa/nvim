-- lsp setup
-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file

require("project_nvim").setup {}
require('telescope').load_extension('projects')
require('telescope').setup {
    defaults = {
        '--ignore-file',
        '.pnpm'
    }
}
require 'nvim-tree'.setup {}

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

require("mason").setup()
require("mason-lspconfig").setup_handlers({
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
})
