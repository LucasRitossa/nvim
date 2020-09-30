syntax on

set noerrorbells
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

call plug#begin('~/.config/nvim/plugged')
    Plug 'drewtempelmeyer/palenight.vim'
	Plug 'leafgarland/typescript-vim'
	Plug 'lyuts/vim-rtags'
    Plug 'pangloss/vim-javascript'
    Plug 'ap/vim-css-color'
call plug#end()

let g:palenight_terminal_italics=1

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme palenight

let mapleader = " "

hi Normal guibg=NONE ctermbg=NONE

command! -nargs=0 Prettier :CocCommand prettier.formatFile

nmap <leader>f  <Plug>(coc-format-selected)

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1


