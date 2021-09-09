-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------
-- plugin: nvim-lspconfig
--- For language server setup see: https://github.com/neovim/nvim-lspconfig

-- This file can be loaded by calling `require('module_name')` from your
--- `init.lua`
  local servers = {'gopls','bashls','pyright','html','jsonls', 'clangd', 'cssls', 'html'}
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
    }
  end


-- HTML, CSS, JavaScript --> vscode-html-languageserver
--- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#html
--- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
