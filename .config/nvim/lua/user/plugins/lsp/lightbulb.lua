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
    float = {
      enabled = true,
      text = "",
      win_opts = {
        border = 'none',
      },
    },
    autocmd = {
      enabled = true,
      pattern = { "*" },
      events = { "CursorHold", "CursorHoldI" }
    },
  })

  vim.api.nvim_command('highlight LightBulbVirtualText guifg=Yellow ctermfg=Yellow')
  vim.api.nvim_command('highlight LightBulbFloatWin guifg=Yellow ctermfg=Yellow')
end

return M
