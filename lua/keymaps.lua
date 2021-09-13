-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
--- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------
-- swap between first 2 buffers
map('n','<leader>n', '<C-^>', default_opts)
-- clear search highlighting
map('n', '<leader>V', ':nohl<CR>', default_opts)

-- don't use arrow keys
map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})

-- fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>', default_opts)

-- move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-----------------------------------------------------------
-- Plugins shortcuts:
-----------------------------------------------------------
-- nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)       -- open/close
map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)  -- refresh

--  telescope
map('n', '<leader>p', ':Telescope fd<CR>', default_opts)       -- open/close

-- formatter
map('n', '<leader>c', ':Format<CR>',default_opts)


