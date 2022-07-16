local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

----------------------------------------------------------------------------------------------------
-- Remap leader key
----------------------------------------------------------------------------------------------------
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

----------------------------------------------------------------------------------------------------
-- Keymaps
----------------------------------------------------------------------------------------------------
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Save file
keymap('n', '<c-s>', ':w<CR>', opts)
keymap('i', '<c-s>', '<Esc>:w<CR>a', opts)
-- Window jumping
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)
-- Window resize
keymap("n", "<C-Up>", ":resize +1<CR>", opts)
keymap("n", "<C-Down>", ":resize -1<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts) -- don't update with deleted text
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>", opts)
keymap("v", "<A-k>", ":m .-2<CR>", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv", opts)

-- Terminal
keymap('t', '<C-[>', '<C-\\><C-n>', term_opts)
keymap('t', '<Esc>', '<C-\\><C-n>', term_opts)

-- HLSEARCH
keymap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)

-- WINDOWS
--keymap("n", "<m-v>", "<cmd>vsplit<cr>", opts)
--keymap("n", "<m-s>", "<cmd>split<cr>", opts)
keymap("n", "<m-q>", "<cmd>q<cr>", opts)

-- GOTO
keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)

-- Telescope
keymap(
  "n",
  "<leader>f",
  "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
  opts)
keymap("n", "<leader>l", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>r", "<cmd>Telescope oldfiles<cr>", opts)

-- Nvim-tree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)

-- Bufferline
function DeleteCurrentBuffer()
  local cbn = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({ buflisted = true })
  local size = 0
  local idx = 0
  for n, e in ipairs(buffers) do
    size = size + 1
    if e.bufnr == cbn then
      idx = n
    end
  end
  if idx == 0 then return end
  if idx == size then
    vim.cmd("bprevious")
  else
    vim.cmd("bnext")
  end
  vim.cmd("bdelete " .. cbn)
end

keymap("n", "<leader>d", "<cmd>lua DeleteCurrentBuffer()<cr>", opts)

-- Formatting
keymap("n", "<leader>m", "<cmd>write<cr><cmd>lua vim.lsp.buf.formatting()<cr>", opts)
----------------------------------------------------------------------------------------------------
-- Aliases
----------------------------------------------------------------------------------------------------
vim.cmd("cnoreabbrev hs split")
