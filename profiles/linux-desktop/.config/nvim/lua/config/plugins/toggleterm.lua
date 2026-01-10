local M = {
  "akinsho/toggleterm.nvim",
  config = function()
    local toggleterm = require("toggleterm")
    local terminal = require("toggleterm.terminal")

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
        vim.api.nvim_buf_set_keymap(0, 'n', 'q', "<cmd>bdelete!<cr>", { noremap = true })
      end
    })

    local function term_save()
      local state = {
        mouse = vim.opt.mouse,
        number = vim.opt.number,
      }
      return state
    end

    local function term_restore(state)
      vim.opt.mouse = state.mouse
      vim.opt.number = state.number
    end

    local function term_fix(term, opts)
      local defaults = { escape = true, window = true, number = false }
      opts = vim.tbl_extend("force", defaults, opts or {})
      if opts.escape then
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-[>')
      end
      if opts.window then
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-h>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-j>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-k>')
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-l>')
      end
      if opts.number then
        vim.opt.number = true
      end
    end

    vim.api.nvim_create_user_command("ToggleTermTab", function()
      local state = term_save()
      terminal.Terminal:new({
        direction = 'tab',
        hidden = false,
        on_open = function(term)
          term_fix(term, { escape = false, number = true })
        end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermFloat", function()
      local state = term_save()
      terminal.Terminal:new({
        direction = 'float',
        hidden = false,
        on_open = function(term) term_fix(term) end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermHtop", function()
      local state = term_save()
      terminal.Terminal:new({
        cmd = 'htop',
        direction = 'float',
        hidden = true,
        on_open = function(term) term_fix(term) end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermLazygit", function()
      local state = term_save()
      terminal.Terminal:new({
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
        on_open = function(term) term_fix(term) end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermLazydocker", function()
      local state = term_save()
      terminal.Terminal:new({
        cmd = 'lazydocker',
        hidden = true,
        direction = 'float',
        on_open = function(term) term_fix(term) end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermK9s", function()
      local state = term_save()
      terminal.Terminal:new({
        cmd = 'k9s',
        direction = 'float',
        hidden = true,
        on_open = function(term) term_fix(term) end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})
  end,
  keys = {
    { "<C-\\>",     "<cmd>ToggleTerm<cr>",           desc = "Toggle terminal" },
    { "<leader>jt", "<cmd>ToggleTermTab<cr>",        desc = "Toggle terminal in tab" },
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
