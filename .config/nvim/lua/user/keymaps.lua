local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }

-- Save file
keymap('n', '<c-s>', ':w<CR>', opts)
keymap('i', '<c-s>', '<Esc>:w<CR>a', opts)
-- Window jumping
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)
-- Terminal normal mode emulation
keymap('t', '<C-[>', '<C-\\><C-n>', opts)
keymap('t', '<Esc>', '<C-\\><C-n>', opts)

