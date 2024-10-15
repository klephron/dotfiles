local M = {
  "akinsho/toggleterm.nvim",
  config = function()
    local toggleterm = require("toggleterm")
    local api = vim.api

    toggleterm.setup({
      open_mapping = [[<c-\>]],
      shade_filetypes = { 'none' },
      direction = 'horizontal',
      insert_mappings = false,
      start_in_insert = true,
      float_opts = { border = 'rounded', winblend = 0 },
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
      on_open = function()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, 'n', 'q', "<cmd>bdelete!<cr>", opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end
    })

    -- Custom cmds
    local Terminal = require('toggleterm.terminal').Terminal

    local function float_keymaps_delete(term)
      if vim.fn.maparg('<esc>', 't') ~= '' then
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-[>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-j>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-k>')
      end
    end

    local opts_prev = {
      mouse = vim.opt.mouse
    }

    -- Floating terminals
    api.nvim_create_user_command("ToggleTermLazygit", function()
      local lazygit = Terminal:new({
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
        on_open = float_keymaps_delete,
      })
      lazygit:toggle()
    end, {})

    api.nvim_create_user_command("ToggleTermLazydocker", function()
      local lazygit = Terminal:new({
        cmd = 'lazydocker',
        hidden = true,
        direction = 'float',
        on_open = float_keymaps_delete,
      })
      lazygit:toggle()
    end, {})

    api.nvim_create_user_command("ToggleTermHtop", function()
      local htop = Terminal:new({
        cmd = 'htop',
        direction = 'float',
        hidden = true,
        on_open = function(term)
          float_keymaps_delete(term)
          vim.opt.mouse = 'a'
        end,
        on_close = function(_)
          vim.opt.mouse = opts_prev["mouse"]
        end
      })
      htop:toggle()
    end, {})

    api.nvim_create_user_command("ToggleTermFloat", function()
      local htop = Terminal:new({
        direction = 'float',
        hidden = false,
        on_open = function(term)
          float_keymaps_delete(term)
          vim.opt.mouse = 'a'
        end,
        on_close = function(_)
          vim.opt.mouse = opts_prev["mouse"]
        end
      })
      htop:toggle()
    end, {})
  end,
  keys = {
    { "<leader>j",  group = "toggleterm" },
    { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "toggleterm: Open terminal" },
    { "<leader>ja", "<cmd>ToggleTermToggleAll<cr>", desc = "toggleterm: Toggle all" },
    { "<leader>jf", "<cmd>ToggleTermFloat<cr>",     desc = "toggleterm: Float" },
    { "<leader>jh", "<cmd>ToggleTermHtop<cr>",      desc = "toggleterm: Htop" },
    { "<leader>jl", "<cmd>ToggleTermLazygit<cr>",   desc = "toggleterm: Lazygit" },
    { "<leader>jd", "<cmd>ToggleTermLazydocker<cr>",   desc = "toggleterm: Lazydocker" },
    { "<leader>jt", "<cmd>ToggleTerm<cr>",          desc = "toggleterm: Toggle" },
  }
}

return M
