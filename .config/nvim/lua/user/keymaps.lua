-- TERMINAL BUFFER LOCAL
function _G._set_terminal_keymaps()
  local opts = { buffer = 0 }
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

us.set_keynomap({"n", "i"}, "<A-s>", "<cmd>write<cr>", "buffer: Save")

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
    ["<C-k>"] = { "<c-w>k", "window: Move up" },
    ["<C-l>"] = { "<c-w>l", "window: Move right" },
    ["<C-j>"] = { "<c-w>j", "window: Move down" },
    ["<C-h>"] = { "<c-w>h", "window: Move left" },

    ["<C-Up>"] = { "<cmd>resize +1<cr>", "window: Increase height" },
    ["<C-Down>"] = { "<cmd>resize -1<cr>", "window: Decrease height" },
    ["<C-Right>"] = { "<cmd>vertical resize +2<cr>", "window: Increase width" },
    ["<C-Left>"] = { "<cmd>vertical resize -2<cr>", "window: Decrease width" },

    ["<S-l>"] = { "<cmd>bnext<cr>", "buffer: Move next" },
    ["<S-h>"] = { "<cmd>bprevious<cr>", "buffer: Move previous" },

    ["<esc><esc>"] = { "<cmd>nohlsearch<cr>", "hl: Clear search hl" },

    ["<M-q>"] = { "<cmd>q<cr>", "window: Close" },

    ["gx"] = { ":silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<cr>", "goto: Open link in system browser" },

    ["<leader>"] = {
      f = {
        "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
        "telescope: Find files"
      },
      l = { "<cmd>Telescope live_grep<cr>", "telescope: Search pattern" },
      r = { "<cmd>Telescope oldfiles<cr>", "telescope: Recent files" },
      p = { "<cmd>Telescope projects<cr>", "telescope: Projects" },

      e = { "<cmd>NvimTreeToggle<cr>", "nvim-tree: Toggle" },

      d = { "<cmd>lua us.delete_current_buffer()<cr>", "buffer: Delete current" },

      m = { "<cmd>write<cr><cmd>lua vim.lsp.buf.formatting()<cr>", "lsp: Format current buffer" },

      ["'"] = { "<cmd>marks<cr>", "mark: Show" },
      ['"'] = { "<cmd>reg<cr>", "register: Show" },
    },
    ["C-w>"] = {
      name = "window",
      s = "Split horizontally",
      v = "Split vertically",
      n = "Split horizontally and edit [New File]",
      ["^"] = "Split horizontally and edit the alternative file",
      c = "Close",
      o = "Close all except current one",
      t = "Go to top-left",
      b = "Go to bottom-right",
      p = "Go to previous",
      P = "Go to preview",
      r = "Rotate downwards/rightwards",
      R = "Rotate upwards/leftwards",
      K = "Move far Top",
      J = "Move far Bottom",
      H = "Move far Left",
      L = "Move far Right",

    }
  }, { mode = "n" })
  ---------------------------------------------------------------------------//
  -- INSERT
  ---------------------------------------------------------------------------//
  which_key.register({

  }, { mode = "i" })
  ---------------------------------------------------------------------------//
  -- VISUAL-SELECT
  ---------------------------------------------------------------------------//
  which_key.register({
    ["<"] = { "<gv", "Shift leftwards" },
    [">"] = { ">gv", "Shift rightwards" },
    ["p"] = { '"_dP', "Replace selected from buffer" },
    ["<A-j>"] = { ":move '>+1<cr>gv", "Swap selected with next line" },
    ["<A-k>"] = { ":move '<-2<cr>gv", "Swap selected with previous line" },
  }, { mode = "v" })
  ---------------------------------------------------------------------------//
  -- TERMINAL
  ---------------------------------------------------------------------------//
  -- local function termcodes(str)
  --   return vim.api.nvim_replace_termcodes(str, true, true, true)
  -- end
  --
  which_key.register({
    --   ["<Esc>"] = { termcodes "<C-\\><C-n>", "Go to normal mode" },
    --   ["<C-[>"] = { termcodes "<C-\\><C-n>", "Go to normal mode" },
  }, { mode = "t" })
end
