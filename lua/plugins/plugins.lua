
return {
	{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
	{
	  "williamboman/mason.nvim",
	  "williamboman/mason-lspconfig.nvim",
	  "neovim/nvim-lspconfig",
	},
	{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
	ensure_installed = "all",
	auto_install = true,
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
 }
}
