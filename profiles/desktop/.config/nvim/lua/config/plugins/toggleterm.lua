local M = {
  "akinsho/toggleterm.nvim",
  config = function()
    local toggleterm = require("toggleterm")

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

    local term_defaults = {
      mouse = vim.opt.mouse
    }

    local function term_restore()
      vim.opt.mouse = term_defaults.mouse
    end

    local function term_del_keymaps(term)
      if vim.fn.maparg('<esc>', 't') ~= '' then
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-[>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-h>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-j>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-k>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-l>')
      end
    end

    vim.api.nvim_create_user_command("ToggleTermFloat", function()
      require('toggleterm.terminal').Terminal:new({
        direction = 'float',
        hidden = false,
        on_open = function(term)
          term_del_keymaps(term)
          vim.opt.mouse = 'a'
        end,
        on_close = term_restore,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermHtop", function()
      require('toggleterm.terminal').Terminal:new({
        cmd = 'htop',
        direction = 'float',
        hidden = true,
        on_open = term_del_keymaps,
        on_close = term_restore,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermLazygit", function()
      require('toggleterm.terminal').Terminal:new({
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
        on_open = term_del_keymaps,
        on_close = term_restore,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermLazydocker", function()
      require('toggleterm.terminal').Terminal:new({
        cmd = 'lazydocker',
        hidden = true,
        direction = 'float',
        on_open = term_del_keymaps,
        on_close = term_restore,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermK9s", function()
      require('toggleterm.terminal').Terminal:new({
        cmd = 'k9s',
        direction = 'float',
        hidden = true,
        on_open = term_del_keymaps,
        on_close = term_restore,
      }):toggle()
    end, {})
  end,
  keys = {
    { "<C-\\>",     "<cmd>ToggleTerm<cr>",           desc = "Toggle terminal" },
    { "<leader>jt", "<cmd>ToggleTerm<cr>",           desc = "Toggle terminal" },
    { "<leader>ja", "<cmd>ToggleTermToggleAll<cr>",  desc = "Toggle all terminals" },
    { "<leader>jf", "<cmd>ToggleTermFloat<cr>",      desc = "Open float terminal" },
    { "<leader>jh", "<cmd>ToggleTermHtop<cr>",       desc = "Open htop" },
    { "<leader>jl", "<cmd>ToggleTermLazygit<cr>",    desc = "Open lazygit" },
    { "<leader>jd", "<cmd>ToggleTermLazydocker<cr>", desc = "Open lazydocker" },
    { "<leader>jk", "<cmd>ToggleTermK9s<cr>",        desc = "Open k9s" },
    {
      "<CR>",
      function()
        require("toggleterm")
            .send_lines_to_terminal("visual_selection", false, { args = vim.v.count })
      end,
      mode = "v",
      desc = "Send lines to terminal"
    },
    {
      "<C-CR>",
      function()
        require("toggleterm")
            .send_lines_to_terminal("single_line", false, { args = vim.v.count })
      end,
      mode = "n",
      desc = "Send current line to terminal"
    },
  }
}

return M
