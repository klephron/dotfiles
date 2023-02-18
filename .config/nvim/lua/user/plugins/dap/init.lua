local M = {
  {
    'mfussenegger/nvim-dap-python',
    lazy = true,
  }
}
-- dependencies
table.insert(M, conf_require("dap.dap"))
return M
