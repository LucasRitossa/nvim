call plug#begin('~/.config/nvim/plugged')
  Plug 'neovim/nvim-lspconfig'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ryanoasis/vim-devicons'
  Plug 'chrisbra/Colorizer'
  Plug 'rhysd/vim-clang-format'
  Plug 'frazrepo/vim-rainbow'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'sainnhe/gruvbox-material'
  Plug 'itchyny/lightline.vim'
  Plug 'vim-syntastic/syntastic'
  Plug 'jackguo380/vim-lsp-cxx-highlight'
  Plug 'evanleck/vim-svelte'
call plug#end()
  let mapleader = " "
  " ctrlp
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

  " j/k will move virtual lines (lines that wrap)
  noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
  noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
  "loads rainbow pairs on these files 
  au FileType c,cpp,objc,objcpp call rainbow#load()

  set number
  set cindent
  set smarttab
  set tabstop=2
  set shiftwidth=2
	set expandtab
  set shortmess+=c
  set updatetime=300
  set noshowmode
  set clipboard=unnamedplus
  set cmdheight=2
  "============coloring config============""
  syntax on

  let g:lightline = {"colorscheme": "jellybeans"}

  set termguicolors
  colorscheme gruvbox-material
  let g:nvcode_termcolors=256
  let g:nvcode_hide_endofbuffer=1
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1 
  hi Normal guibg=NONE ctermbg=NONE
  hi StatusLine ctermbg=none cterm=bold

:lua << EOF
  require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    use_languagetree = false,
  },
}
EOF

"============keybindings============"
  nnoremap <leader>s <Esc>:w<cr>
  nnoremap <leader>y "*y 
  nnoremap <Leader>c :<C-u>ClangFormat<CR>
  nnoremap <expr> O getline('.') =~ '^\s*//' ? 'O<esc>S' : 'O'
  nnoremap <expr> o getline('.') =~ '^\s*//' ? 'o<esc>S' : 'o'
  nnoremap <leader>t :!groff -ms groff.ms -T pdf > groff.pdf<CR>
"=============coc================"

"disable coc-pairs on filetype
  autocmd FileType cpp let b:coc_pairs_disabled=["<"]
  
  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-eslint', 
    \ 'coc-prettier', 
    \ 'coc-json', 
    \ ]

  nnoremap <silent> K :call <SID>show_documentation()<CR>
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

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

  nnoremap <Leader>f :<C-u>ClangFormat<CR>
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
augroup END

