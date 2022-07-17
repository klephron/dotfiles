return function()
  local wk_ok, which_key = us.safe_require("which-key")
  if not wk_ok then
    return
  end
  -- https://github.com/folke/which-key.nvim
  which_key.setup({
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 30, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, v, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = "none", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 1, 4, 1, 4 }, -- extra window padding [top, right, bottom, left]
      winblend = 0
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 30, max = 57 }, -- min and max width of the columns
      spacing = 4, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  })

  -- :WhichKey " show all mappings
  -- :WhichKey <leader> " show all <leader> mappings
  -- :WhichKey <leader> v " show all <leader> mappings for VISUAL mode
  -- :WhichKey '' v " show ALL mappings for VISUAL mode

  -- Modes
  --   normal_mode = "n",
  --   insert_mode = "i",
  --   visual_mode = "v",
  --   visual_block_mode = "x",
  --   term_mode = "t",
  --   command_mode = "c",

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
  -- VISUAL
  ---------------------------------------------------------------------------//
  which_key.register({
    ["<"] = { "<gv", "Shift leftwards" },
    [">"] = { ">gv", "Shift rightwards" },

    ["p"] = { '"_dP', "Paste from buffer" },

    ["<A-j>"] = { ":m .+1<cr>", "Swap selected with bottom" },
    ["<A-k>"] = { ":m .-2<cr>", "Swap selected with top" },

  }, { mode = "v" })
  ---------------------------------------------------------------------------//
  -- VISUAL LINE
  ---------------------------------------------------------------------------//
  which_key.register({
    ["<A-j>"] = { ":move '>+1<cr>gv", "Swap selected with bottom" },
    ["<A-k>"] = { ":move '<-2<cr>gv", "Swap selected with top" },
  }, { mode = "x" })
  ---------------------------------------------------------------------------//
  -- TERMINAL
  ---------------------------------------------------------------------------//
  local function termcodes(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  which_key.register({
    ["<C-[>"] = { termcodes "<C-\\><C-n>", "Go to normal mode" },
    ["<Esc>"] = { termcodes "<C-\\><C-n>", "Go to normal mode" },
  }, { mode = "t" })
end
