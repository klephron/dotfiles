local M = {}

function M.setup()
  local lightbulb_ok, lightbulb = safe_require("nvim-lightbulb")
  if not lightbulb_ok then
    return
  end
  lightbulb.setup({
    ignore = { 'null-ls' },
    sign = {
      enabled = false,
      priority = 10,
    },
    virtual_text = {
      enabled = true,
      text = require("user.icons").diagnostics.lightbulb,
      hl_mode = "blend",
    },
    float = {
      enabled = false,
      text = require("user.icons").diagnostics.lightbulb,
      win_opts = {
        border = 'none',
      },
    },
    autocmd = { enabled = true, },
  })
  -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]

  vim.api.nvim_command('highlight LightBulbVirtualText guifg=Yellow ctermfg=Yellow')
  vim.api.nvim_command('highlight LightBulbFloatWin guifg=Yellow ctermfg=Yellow')
end

return M
