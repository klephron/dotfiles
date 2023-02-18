local M = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
}

local function setup()
  -- Configure dap
  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  -- vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = nil, numhl = '' })

end

function M.config()
  local keymaps = conf_require("dap.sfn.keymaps")
  local langs = conf_require("dap.sfn.langs")

  setup()

  keymaps.setup()
  langs.setup()
end

return M
