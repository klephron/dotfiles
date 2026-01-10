local M = {
  "akinsho/toggleterm.nvim",
  config = function()
    local toggleterm = require("toggleterm")
    local terminal = require("toggleterm.terminal")

    toggleterm.setup({
      open_mapping = [[<c-\>]],
      shade_filetypes = { 'none' },
      insert_mappings = false,
      float_opts = { border = 'rounded', winblend = 0 },
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

    local function term_map(term, opts)
      local defaults = { escape = true, window = true, number = false }
      opts = vim.tbl_extend("force", defaults, opts or {})

      vim.api.nvim_buf_set_keymap(0, 'n', 'q', "<cmd>Bdelete!<cr>", { noremap = true })

      if opts.escape then
        pcall(vim.api.nvim_buf_del_keymap, term.bufnr, 't', '<esc>')
        pcall(vim.api.nvim_buf_del_keymap, term.bufnr, 't', '<C-[>')
      end
      if opts.window then
        pcall(vim.api.nvim_buf_del_keymap, term.bufnr, 't', '<C-h>')
        pcall(vim.api.nvim_buf_del_keymap, term.bufnr, 't', '<C-j>')
        pcall(vim.api.nvim_buf_del_keymap, term.bufnr, 't', '<C-k>')
        pcall(vim.api.nvim_buf_del_keymap, term.bufnr, 't', '<C-l>')
      end
      if opts.number then
        vim.opt.number = true
      end
    end

    vim.api.nvim_create_user_command("ToggleTermHorizontal", function()
      local state = term_save()
      terminal.Terminal:new({
        direction = 'horizontal',
        on_open = function(term)
          term_map(term, { escape = false, window = false, number = false })
        end,
        on_close = function() term_restore(state) end,
        size = function() return 15 end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermTab", function()
      local state = term_save()
      terminal.Terminal:new({
        direction = 'tab',
        display_name = 'tab',
        on_open = function(term)
          term_map(term, { escape = false, number = true })
        end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermFloat", function()
      local state = term_save()
      terminal.Terminal:new({
        direction = 'float',
        hidden = false,
        on_open = function(term) term_map(term) end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermHtop", function()
      local state = term_save()
      terminal.Terminal:new({
        cmd = 'htop',
        direction = 'float',
        hidden = true,
        on_open = function(term) term_map(term) end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermLazygit", function()
      local state = term_save()
      terminal.Terminal:new({
        cmd = 'lazygit',
        direction = 'float',
        hidden = true,
        on_open = function(term) term_map(term) end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermLazydocker", function()
      local state = term_save()
      terminal.Terminal:new({
        cmd = 'lazydocker',
        direction = 'float',
        hidden = true,
        on_open = function(term) term_map(term) end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})

    vim.api.nvim_create_user_command("ToggleTermK9s", function()
      local state = term_save()
      terminal.Terminal:new({
        cmd = 'k9s',
        direction = 'float',
        hidden = true,
        on_open = function(term) term_map(term) end,
        on_close = function() term_restore(state) end,
      }):toggle()
    end, {})
  end,
  keys = {
    { "<C-\\>",     "<cmd>ToggleTerm<cr>",           desc = "Toggle terminal" },
    { "<leader>js", "<cmd>TermSelect<cr>",           desc = "Select terminal" },
    { "<leader>ja", "<cmd>ToggleTermToggleAll<cr>",  desc = "Toggle all terminals" },
    { "<leader>jy", "<cmd>ToggleTermHorizontal<cr>", desc = "Toggle terminal horizontal" },
    { "<leader>jt", "<cmd>ToggleTermTab<cr>",        desc = "Toggle terminal in tab" },
    { "<leader>jf", "<cmd>ToggleTermFloat<cr>",      desc = "Toggle float terminal" },
    { "<leader>jh", "<cmd>ToggleTermHtop<cr>",       desc = "Toggle htop" },
    { "<leader>jl", "<cmd>ToggleTermLazygit<cr>",    desc = "Toggle lazygit" },
    { "<leader>jd", "<cmd>ToggleTermLazydocker<cr>", desc = "Toggle lazydocker" },
    { "<leader>jk", "<cmd>ToggleTermK9s<cr>",        desc = "Toggle k9s" },
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
