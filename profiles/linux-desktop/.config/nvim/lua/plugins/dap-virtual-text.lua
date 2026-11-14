return {
  'theHamsta/nvim-dap-virtual-text',
  dependencies = {
    {
      'mfussenegger/nvim-dap',
    },
  },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-dap-virtual-text").setup({})
  end
}
