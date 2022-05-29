vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.cmd("colorscheme desert")
vim.opt.clipboard="unnamedplus"

local keymap = vim.api.nvim_set_keymap
keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<Esc>:w<CR>a', {})
local opts = { noremap = true }
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)
keymap('t', '<C-[>', '<C-\\><C-n>', opts)
keymap('t', '<Esc>', '<C-\\><C-n>', opts)

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
end)

