-- TERMINAL BUFFER LOCAL
function _G._set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua _set_terminal_keymaps()')

-- Modes
--   normal_mode = "n",
--   visual_and_select = "v",
--   select_mode = "s",
--   visual_mode = "v",
--   operator-pending_mode = "o",
--   insert_mode = "i",
--   term_mode = "t",
--   command_mode = "c",

---------------------------------------------------------------------------//
-- WHICH_KEY
---------------------------------------------------------------------------//
local which_key_ok, which_key = safe_require("which-key")
if which_key_ok then
  ---------------------------------------------------------------------------//
  -- NORMAL
  ---------------------------------------------------------------------------//
  which_key.register({
    -- configure later
    ["<C-s>"] = { "<cmd>write<cr>", "Save File" },

    ["<C-k>"] = { "<c-w>k", "Move to Up window" },
    ["<C-l>"] = { "<c-w>l", "Move to Right window" },
    ["<C-j>"] = { "<c-w>j", "Move to Down window" },
    ["<C-h>"] = { "<c-w>h", "Move to Left window" },

    ["<C-Up>"] = { "<cmd>resize +1<cr>", "Increase window length" },
    ["<C-Down>"] = { "<cmd>resize -1<cr>", "Decrease window length" },
    ["<C-Right>"] = { "<cmd>vertical resize +2<cr>", "Increase window width" },
    ["<C-Left>"] = { "<cmd>vertical resize -2<cr>", "Decrease window width" },

    ["<S-l>"] = { "<cmd>bnext<cr>", "Move buffer next" },
    ["<S-h>"] = { "<cmd>bprevious<cr>", "Move buffer previous" },

    ["<esc><esc>"] = { "<cmd>nohlsearch<cr>", "Clear search highlight" },

    ["<M-q>"] = { "<cmd>q<cr>", "Exit" },

    ["gx"] = { ":silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<cr>", "Open in system browser" },

    ["<leader>"] = {
      f = {
        "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
        "Telescope find_files"
      },
      l = { "<cmd>Telescope live_grep<cr>", "Telescope search pattern" },
      r = { "<cmd>Telescope oldfiles<cr>", "Telescope recent files" },
      p = { "<cmd>Telescope projects<cr>", "Telescope projects"},

      e = { "<cmd>NvimTreeToggle<cr>", "Nvim-tree toggle" },

      d = { "<cmd>lua us.delete_current_buffer()<cr>", "Delete current buffer"},

      m = { "<cmd>write<cr><cmd>lua vim.lsp.buf.formatting()<cr>", "Format current buffer"},
    }
  }, { mode = "n" })
  ---------------------------------------------------------------------------//
  -- INSERT
  ---------------------------------------------------------------------------//
  which_key.register({
    -- configure later
    ["<C-s>"] = { "<cmd>write<cr>", "Save File" },
  }, { mode = "i" })
  ---------------------------------------------------------------------------//
  -- VISUAL-SELECT
  ---------------------------------------------------------------------------//
  which_key.register({
    ["<"] = { "<gv", "Shift leftwards" },
    [">"] = { ">gv", "Shift rightwards" },
    ["p"] = { '"_dP', "Paste from buffer" },
    ["<A-j>"] = { ":move '>+1<cr>gv", "Swap selected with bottom" },
    ["<A-k>"] = { ":move '<-2<cr>gv", "Swap selected with top" },
  }, { mode = "v" })
  ---------------------------------------------------------------------------//
  -- TERMINAL
  ---------------------------------------------------------------------------//
  -- local function termcodes(str)
  --   return vim.api.nvim_replace_termcodes(str, true, true, true)
  -- end
  --
  -- which_key.register({
  --   ["<Esc>"] = { termcodes "<C-\\><C-n>", "Go to normal mode" },
  --   ["<C-[>"] = { termcodes "<C-\\><C-n>", "Go to normal mode" },
  -- }, { mode = "t" })
end
