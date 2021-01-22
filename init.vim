call plug#begin('~/.config/nvim/plugged')
  Plug 'mhartington/oceanic-next'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'srcery-colors/srcery-vim'
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'sbdchd/neoformat'
  Plug 'jackguo380/vim-lsp-cxx-highlight'
  Plug 'evanleck/vim-svelte'
  Plug '9mm/vim-closer'
  Plug 'tpope/vim-commentary'
  Plug 'honza/vim-snippets'
  Plug 'tjdevries/nlua.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'sainnhe/edge'
  Plug 'kjwon15/vim-transparent'
  Plug 'jiangmiao/auto-pairs'
  Plug 'sainnhe/gruvbox-material'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nanotech/jellybeans.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'wadackel/vim-dogrun'
  Plug 'kaicataldo/material.vim'
call plug#end()

  let mapleader = " "

  set ts=2 sts=2 sw=2 et lcs=precedes:,extends:
  set hid nowrap spr sb ic scs tgc nosmd swb=useopen scl=yes nosc noru icm=split
  set udir=~/.config/nvim/undodir udf
  set cot=menuone,noinsert,noselect shm+=c
  set bg=dark
  set nohlsearch

  colo material
  let g:material_theme_style = 'palenight'
  let g:lightline = {
  \ 'colorscheme': 'palenight',
  \ }
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:palenight_terminal_italics=1
  hi StatusLine ctermbg=none cterm=bold

  let g:diagnostic_virtual_text_prefix = '<'
  let g:diagnostic_enable_virtual_text = 1
  let g:completion_confirm_key = "\<C-y>"
  let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
  let g:fzf_layout = { 'window' : {'width': 0.8, 'height': 0.8} }
  let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
  let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'

  :lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}
EOF


"============keybindings============"
  nnoremap <Leader>q" ciw""<Esc>P
  nnoremap <Leader>q' ciw''<Esc>P
  nnoremap <Leader>qd daW"=substitute(@@,"'\\\|\"","","g")<CR>P
  nnoremap <leader>s <Esc>:w<cr>
  nnoremap <leader>y "*y 
  nnoremap <leader>c :Neoformat<CR>
  nnoremap <expr> O getline('.') =~ '^\s*//' ? 'O<esc>S' : 'O'
  nnoremap <expr> o getline('.') =~ '^\s*//' ? 'o<esc>S' : 'o'
  nnoremap <leader>t :!groff -ms groff.ms -T pdf > groff.pdf<CR>
  nnoremap <leader>p :Files<CR>

"cpp stuff
" for detecting OS

  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:syntastic_cpp_checkers = ['cpplint']
  let g:syntastic_c_checkers = ['cpplint']
  let g:syntastic_cpp_cpplint_exec = 'cpplint'
  " The following two lines are optional. Configure it to your liking!
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  " Make Ranger replace netrw and be the file explorer
  let g:rnvimr_ex_enable = 1
  nmap <space>r :e .<CR>
  nmap <space>b :buffer <tab><CR>

  if !exists("g:os")
      if has("win64") || has("win32") || has("win16")
          let g:os = "Windows"
      else
          let g:os = substitute(system('uname'), '\n', '', '')
      endif
  endif

  " important option that should already be set!
  set hidden

  " available options:
  " * g:split_term_style
  " * g:split_term_resize_cmd
  function! TermWrapper(command) abort
	if !exists('g:split_term_style') | let g:split_term_style = 'vertical' | endif
	if g:split_term_style ==# 'vertical'
		let buffercmd = 'vnew'
	elseif g:split_term_style ==# 'horizontal'
		let buffercmd = 'new'
	else
		echoerr 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'' but is currently set to ''' . g:split_term_style . ''')'
		throw 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'')'
	endif
	if exists('g:split_term_resize_cmd')
		exec g:split_term_resize_cmd
	endif
	exec buffercmd
	exec 'term ' . a:command
	exec 'startinsert'
endfunction

command! -nargs=0 CompileAndRun call TermWrapper(printf('g++ -std=c++11 %s && ./a.out', expand('%')))
command! -nargs=0 CompileAndRun2 call TermWrapper(printf('gcc %s && ./a.out', expand('%')))
command! -nargs=1 CompileAndRunWithFile call TermWrapper(printf('g++ -std=c++11 %s && ./a.out < %s', expand('%'), <args>))
autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>

augroup CppToolkit
	autocmd!
	if g:os == 'Darwin'
		autocmd FileType cpp nnoremap <leader>fn :!g++ -std=c++11 -o %:r % && open -a Terminal './a.out'<CR>
	endif
	autocmd FileType cpp nnoremap <leader>fb :!g++ -std=c++11 % && ./a.out<CR>
	autocmd FileType cpp nnoremap <leader>fr :!./a.out<CR>
	autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>
	autocmd FileType c nnoremap <leader>fw :CompileAndRun2<CR>
augroup END

source ~/.config/nvim/coc_config.vim
