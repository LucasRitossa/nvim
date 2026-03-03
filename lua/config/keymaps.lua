-- Keymaps configuration
local keymap = vim.keymap.set
local opts = { silent = true }

-- Save file
keymap("n", "<leader>s", "<cmd>w<CR>", opts)

-- Switch to alternate buffer
keymap("n", "<leader>n", "<C-^>", opts)

-- Delete buffer
keymap("n", "<leader>bd", "<cmd>bw!<CR>", opts)

-- Execute shell command from buffer
vim.api.nvim_create_user_command("Execsh", function()
    vim.cmd("set splitright | vnew | set filetype=sh | silent r !sh #")
end, {})
keymap("n", "<leader>rs", "<cmd>Execsh<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Stay in indent mode when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Keep cursor centered when searching
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Paste without yanking replaced text in visual mode
keymap("x", "p", [["_dP]], opts)

-- Quick escape from insert mode
keymap("i", "jk", "<ESC>", opts)
