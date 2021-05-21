call plug#begin('~/.config/nvim/plugged')
  Plug 'tpope/vim-rhubarb'
  Plug 'vim-airline/vim-airline'
  Plug 'p00f/nvim-ts-rainbow' 
  Plug 'kristijanhusak/vim-hybrid-material'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
  Plug 'savq/melange'
  Plug 'morhetz/gruvbox'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/goyo.vim'
  Plug 'mhartington/oceanic-next'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
  Plug 'sbdchd/neoformat'
  Plug 'jackguo380/vim-lsp-cxx-highlight'
  Plug '9mm/vim-closer'
  Plug 'tpope/vim-commentary'
  Plug 'honza/vim-snippets'
  Plug 'tjdevries/nlua.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'sainnhe/edge'
  Plug 'kjwon15/vim-transparent'
  Plug 'jiangmiao/auto-pairs'
  Plug 'sainnhe/gruvbox-material'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nanotech/jellybeans.vim'
  Plug 'wadackel/vim-dogrun'
  Plug 'kaicataldo/material.vim'
  Plug 'tpope/vim-fugitive'
call plug#end()

  let mapleader = " "

  filetype plugin on
  set omnifunc=syntaxcomplete#Complete
  set ts=2 sts=2 sw=2 et lcs=precedes:,extends:
  set nu rnu hid nowrap spr sb ic scs tgc nosmd swb=useopen scl=yes nosc noru icm=split
  set udir=~/.config/nvim/undodir udf
  set cot=menuone,noinsert,noselect shm+=c
  set bg=dark
  set nohlsearch
  set clipboard+=unnamedplus
  "random settings for extensions
  "
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:airline_theme = "gruvbox_material"
  let g:netrw_banner=0
  let g:enable_italic_font = 1
  let g:diagnostic_virtual_text_prefix = '<'
  let g:diagnostic_enable_virtual_text = 1
  let g:completion_confirm_key = "\<C-y>"
  let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
  let g:fzf_layout = { 'window' : {'width': 0.8, 'height': 0.8} }
  let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
  let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
  let g:gruvbox_material_background = 'soft'
  let g:gruvbox_material_palette = 'material'

  colo gruvbox-material
  "lua support (treesitter, rainbow)
  :lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true
  },
  rainbow = {
    enable = true
  },
}
EOF

"============keybindings============"
  "qoutes around text
  nnoremap <Leader>q" ciw""<Esc>P
  nnoremap <Leader>q' ciw''<Esc>P
  " writes changes
  nnoremap <leader>s <Esc>:w<cr>
  " formats code
  nnoremap <leader>c :Neoformat<CR>
  nnoremap <expr> O getline('.') =~ '^\s*//' ? 'O<esc>S' : 'O'
  nnoremap <expr> o getline('.') =~ '^\s*//' ? 'o<esc>S' : 'o'
  " compiles and runs program
  nnoremap <leader>t :!groff -ms groff.ms -T pdf > groff.pdf<CR>
  " fuzzy finder
  nnoremap <leader>p :Files<CR>
  " opens coc expolorer (like vscode)
  nnoremap <leader>v :CocCommand explorer<CR>
  " resizes window splits
  nnoremap <leader>h :vertical resize -10<CR>
  nnoremap <leader>l :vertical resize +10<CR>
  nnoremap <leader>j :res -10<CR>
  nnoremap <leader>k :res +10<CR>
  " Toggles between 2 buffers
  nnoremap <leader>n <C-^>
  " Shows git info
  nnoremap <leader>gs :G<CR>
  " Toggles writing mode
  nnoremap <leader>wm :call ToggleWrap()<CR>
  " places cursor one space from end of line and intents - for opening {}
  nnoremap <C-n> $i<CR><CR><Esc>ki<TAB>
  " adds semi-colon at end of line
  nnoremap <C-l> :delmarks P<CR> mPA;<ESC>`Ph  
  " Removes one char from end of line
  nnoremap <S-l> :delmarks P<CR> mP$x`Ph


  let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist spell
  :Goyo
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction

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
command! -nargs=0 CompileAndRun2 call TermWrapper(printf('go run %s', expand('%')))
command! -nargs=0 CompileAndRun3 call TermWrapper(printf('python %s', expand('%')))
command! -nargs=0 CompileAndRun4 call TermWrapper(printf('java %s', expand('%')))
command! -nargs=0 CompileAndRun5 call TermWrapper(printf('nasm -f elf %s -o a.o && ld -m elf_i386 -s -o a.out a.o && ./a.out', expand('%')))
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
	autocmd FileType go nnoremap <leader>fw :CompileAndRun2<CR>
	autocmd FileType python nnoremap <leader>fw :CompileAndRun3<CR>
	autocmd FileType java nnoremap <leader>fw :CompileAndRun4<CR>
	autocmd FileType asm nnoremap <leader>fw :CompileAndRun5<CR>
augroup END

source ~/.config/nvim/coc_config.vim
