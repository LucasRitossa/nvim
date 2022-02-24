" >> load plugins
call plug#begin(stdpath('data') . 'vimplug')
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim' 
    Plug 'neovim/nvim-lspconfig'
    Plug 'tami5/lspsaga.nvim'
    Plug 'williamboman/nvim-lsp-installer', { 'branch': 'main' }
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/nvim-cmp'

    Plug 'p00f/nvim-ts-rainbow'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'NTBBloodbath/galaxyline.nvim'
    Plug 'kyazdani42/nvim-web-devicons'  " needed for galaxyline icons

    Plug 'srcery-colors/srcery-vim'

    Plug 'ThePrimeagen/harpoon'
    Plug 'tpope/vim-fugitive'
    Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'tomtom/tcomment_vim'
call plug#end()

colorscheme  srcery

" basic settings
syntax on
set termguicolors
set number
set relativenumber
set ignorecase      " ignore case
set smartcase     " but don't ignore it, when search string contains uppercase letters
set nocompatible
set incsearch        " do incremental searching
set visualbell
set expandtab
set tabstop=4
set ruler
set smartindent
set shiftwidth=4
set hlsearch
set cursorline
set virtualedit=all
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent
set mouse=a  " mouse support
set udir=~/.config/nvim/undodir udf
let g:netrw_banner=0

" set leader key to ,
let g:mapleader=" "

" >> Harpoon bindings
nnoremap <silent><C-h> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><C-g> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><C-t> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><C-s> :lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

" >> Telescope bindings
nnoremap <Leader>pp <cmd>lua require'telescope.builtin'.builtin{}<CR>

" most recently used files
nnoremap <Leader>r <cmd>lua require'telescope.builtin'.oldfiles{}<CR>

" find buffer
nnoremap <Leader>b <cmd>lua require'telescope.builtin'.buffers{}<CR>

" find in current buffer
nnoremap <Leader>/ <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>

" bookmarks
nnoremap <Leader>' <cmd>lua require'telescope.builtin'.marks{}<CR>

" git files
nnoremap <Leader>f <cmd>lua require'telescope.builtin'.git_files{}<CR>

" all files
nnoremap <Leader>F <cmd>lua require'telescope.builtin'.find_files{}<CR>

" ripgrep like grep through dir
nnoremap <Leader>rg <cmd>lua require'telescope.builtin'.live_grep{}<CR>

" pick color scheme
nnoremap <Leader>CS <cmd>lua require'telescope.builtin'.colorscheme{}<CR>

" >> Normal Key bindings
nnoremap <Leader>s <Esc>:w<cr>
nnoremap <leader>n <C-^>    

" >> Lsp key bindings
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-p> <cmd>Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> <C-n> <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <Leader>c <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ga    <cmd>Lspsaga code_action<CR>
xnoremap <silent> ga    <cmd>Lspsaga range_code_action<CR>
nnoremap <silent> gs    <cmd>Lspsaga signature_help<CR>

lua <<EOF
require("lsp")
require("treesitter")
require("completion")
require("saga")
require("statusline")
require('pairs')
EOF
