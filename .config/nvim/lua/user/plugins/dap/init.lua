local M = {
  {
    'mfussenegger/nvim-dap-python',
    lazy = true,
  }
}
-- dependencies
table.insert(M, conf_require("dap.dap"))
table.insert(M, conf_require("dap.dap-virtual-text"))
return M
