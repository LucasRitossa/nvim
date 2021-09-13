-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: paq-nvim
--- https://github.com/savq/paq-nvim

vim.cmd 'packadd paq-nvim'            -- load paq
local paq = require('paq-nvim').paq   -- import module with `paq` function

-- Add packages
require 'paq' {
  'savq/paq-nvim';  -- let paq manage itself

  'Mofiqul/vscode.nvim';
  'Yggdroot/indentLine';
  'hoob3rt/lualine.nvim';
  'neovim/nvim-lspconfig';
  'kyazdani42/nvim-tree.lua';
  'kyazdani42/nvim-web-devicons';
  'nvim-treesitter/nvim-treesitter';
  'kabouzeid/nvim-lspinstall';
  'ms-jpq/coq_nvim';
  'ms-jpq/coq.artifacts';
  'kyazdani42/nvim-web-devicons';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  'windwp/nvim-autopairs';
  'tomasiser/vim-code-dark';
}

