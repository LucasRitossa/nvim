" >> load plugins
call plug#begin(stdpath('data') . 'vimplug')
    "lsp
    Plug 'nvim-lua/plenary.nvim'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'nvim-telescope/telescope.nvim' 
    Plug 'ahmedkhalf/project.nvim'
    Plug 'rest-nvim/rest.nvim'

    " completition
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'alvan/vim-closetag'

    "snippets 
    Plug 'L3MON4D3/LuaSnip', {'branch' : 'master'}
    Plug 'rafamadriz/friendly-snippets'

    " visuals
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'  " needed for galaxyline icons

    " themes
    Plug 'srcery-colors/srcery-vim'
    Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}

    "functionality
    Plug 'sindrets/diffview.nvim'
    Plug 'ThePrimeagen/harpoon'
    Plug 'windwp/nvim-autopairs'
    Plug 'tpope/vim-fugitive'

call plug#end()

" config, and load theme
let g:srcery_inverse = 0
colorscheme gruvbox-baby

" make background transparent
hi Normal guibg=NONE ctermbg=NONE

" colors for nvim-cmp
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! mpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

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
set nohlsearch
set wrap!
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

" nvim-tree bindings
nnoremap <Leader>t :NvimTreeToggle<CR>

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

" telescope projects
nnoremap <Leader>pj <cmd>Telescope projects<CR>

" >> Normal Key bindings
nnoremap <Leader>s <Esc>:w<cr>
nnoremap <leader>n <C-^>    

" >> Lsp key bindings
                                       nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>c      <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<CR>

" Exec sh, output split right
command Execsh set splitright | vnew | set filetype=sh | :silent r !sh #

nnoremap <silent> <Leader>rs <cmd>Execsh<CR>

lua <<EOF
require("lsp")
require("mason")
require("completion")
require("statusline")
require('pairs')
require("treesitter")
require("rest")
require("diffview")
EOF
