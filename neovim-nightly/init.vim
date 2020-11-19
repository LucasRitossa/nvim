call plug#begin('~/.config/nvim/plugged')
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'jackguo380/vim-lsp-cxx-highlight'
  Plug 'evanleck/vim-svelte'
  Plug '9mm/vim-closer'
  Plug 'tpope/vim-commentary'
  Plug 'honza/vim-snippets'
  Plug 'tjdevries/nlua.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/diagnostic-nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'sainnhe/edge'
  Plug 'kjwon15/vim-transparent'
  Plug 'jiangmiao/auto-pairs'
call plug#end()

  let mapleader = " "

  set ts=2 sts=2 sw=2 et list lcs=tab:┆·,trail:·,precedes:,extends:
  set hid nowrap spr sb ic scs nu rnu tgc nosmd swb=useopen scl=yes nosc noru icm=split
  set udir=~/.config/nvim/undodir udf
  set cot=menuone,noinsert,noselect shm+=c
  set bg=dark
  let g:edge_style = 'neon'
  colo edge
  
  let g:terminal_color_0 = "#363a4e"
  let g:terminal_color_8 = "#363a4e"
  let g:terminal_color_1 = "#ec7279"
  let g:terminal_color_9 = "#ec7279"
  let g:terminal_color_2 = "#a0c980"
  let g:terminal_color_10 = "#a0c980"
  let g:terminal_color_3 = "#deb974"
  let g:terminal_color_11 = "#deb974"
  let g:terminal_color_4 = "#6cb6eb"
  let g:terminal_color_12 = "#6cb6eb"
  let g:terminal_color_5 = "#d38aea"
  let g:terminal_color_13 = "#d38aea"
  let g:terminal_color_6 = "#5dbbc1"
  let g:terminal_color_14 = "#5dbbc1"
  let g:terminal_color_7 = "#c5cdd9"
  let g:terminal_color_15 = "#c5cdd9"
  let g:terminal_color_background = "#2b2d3a"
  let g:terminal_color_foreground = "#c5cdd9"


    
  let g:signify_sign_add = '|'
  let g:signify_sign_delete = '|'
  let g:signify_sign_delete_first_line = '|'
  let g:signify_sign_change = '|'

  let g:diagnostic_virtual_text_prefix = '<'
  let g:diagnostic_enable_virtual_text = 1
  let g:completion_confirm_key = "\<C-y>"
  let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('diagnostic').on_attach()
    require('completion').on_attach()
    require'lspconfig'.tsserver.setup{}
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end
  local servers = {'jsonls', 'clangd', 'cssls', 'html'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
    nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
EOF

command! -buffer -nargs=0 LspShowLineDiagnostics lua require'jumpLoc'.openLineDiagnostics()
nnoremap <buffer><silent> <C-h> <cmd>LspShowLineDiagnostics<CR>
command! Format execute 'lua vim.lsp.buf.formatting()'

:lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = { },
    },
  }
EOF

"============keybindings============"
  nnoremap <S-h> :call ToggleHiddenAll()<CR>
  nnoremap <leader>s <Esc>:w<cr>
  nnoremap <leader>y "*y 
  nnoremap <Leader>c :<C-u>ClangFormat<CR>
  nnoremap <expr> O getline('.') =~ '^\s*//' ? 'O<esc>S' : 'O'
  nnoremap <expr> o getline('.') =~ '^\s*//' ? 'o<esc>S' : 'o'
  nnoremap <leader>t :!groff -ms groff.ms -T pdf > groff.pdf<CR>

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

