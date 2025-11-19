local M = {
  'theHamsta/nvim-dap-virtual-text',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  enabled = true,
  event = "VeryLazy",
  config = function()
    require("nvim-dap-virtual-text").setup({})
    -- Update highlights
    vim.api.nvim_set_hl(0, "NvimDapVirtualText", { link = "NonText" })
  end
}

return M
