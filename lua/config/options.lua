-- Basic options
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"

-- Nerd Font for GUI so icons render. In a terminal the terminal's font is used;
-- use the same family name there (e.g. in Alacritty). Family must be the Nerd
-- Font patched variant (has PUA glyphs), not plain JetBrains Mono.
opt.guifont = "JetBrains Mono Nerd Font:h11"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Consider - as part of word
opt.iskeyword:append("-")

-- Undo persistence
opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
opt.undofile = true

-- Mouse support
opt.mouse = "a"

-- Virtual edit
opt.virtualedit = "all"

-- Disable netrw banner
vim.g.netrw_banner = 0

-- Visual bell
opt.visualbell = true

-- Ruler
opt.ruler = true
