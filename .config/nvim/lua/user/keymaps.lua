local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }

-- SAVE_FILE
keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<Esc>:w<CR>a', {})
-- WINDOWS
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)
-- TERMINAL
keymap('t', '<C-[>', '<C-\\><C-n>', opts)
keymap('t', '<Esc>', '<C-\\><C-n>', opts)
