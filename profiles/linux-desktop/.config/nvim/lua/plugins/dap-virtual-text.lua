return {
  'theHamsta/nvim-dap-virtual-text',
  dependencies = {
    {
      'mfussenegger/nvim-dap',
    },
  },
  enabled = true,
  event = "VeryLazy",
  config = function()
    require("nvim-dap-virtual-text").setup({})
  end
}
