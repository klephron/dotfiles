return function()
  local toggleterm = require("toggleterm")
  local api = vim.api

  toggleterm.setup({
    open_mapping = [[<c-\>]],
    shade_filetypes = { 'none' },
    direction = 'horizontal',
    insert_mappings = false,
    start_in_insert = true,
    float_opts = { border = 'rounded', winblend = 3 },
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

  local float_handler = function(term)
    -- override global mappings
    -- vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<esc>', "<esc>", {noremap = true})
    -- vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-[>', "<C-[>", {noremap = true})
    if vim.fn.maparg('<esc>', 't') ~= '' then
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-[>')
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-j>')
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-k>')
    end
  end

  local lazygit = Terminal:new({
    cmd = 'cd $NVIM_CWD && lazygit',
    hidden = true,
    direction = 'float',
    on_open = float_handler,
  })

  local htop = Terminal:new({
    cmd = 'htop',
    hidden = true,
    direction = 'float',
    on_open = float_handler,
  })

  api.nvim_create_user_command("UsToggleTermLazygit", function() lazygit:toggle() end, {})
  api.nvim_create_user_command("UsToggleTermHtop", function() htop:toggle() end, {})
end
