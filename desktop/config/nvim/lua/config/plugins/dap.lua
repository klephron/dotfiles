local M = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    local keymaps = p_require("dap.keymaps")
    local langs = p_require("dap.langs")

    vim.api.nvim_set_hl(0, 'DapBreakpoint',
      { ctermbg = 0, fg = "#e41400", bg = nil }
    )
    vim.api.nvim_set_hl(0, 'DapStopped',
      { ctermbg = 0, fg = nil, bg = "#022e4b" }
    )

    vim.fn.sign_define('DapBreakpoint',
      {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = ''
      })
    vim.fn.sign_define('DapBreakpointCondition',
      {
        text = 'ﳁ',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = ''
      })
    vim.fn.sign_define('DapBreakpointRejected',
      {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = ''
      })
    vim.fn.sign_define('DapLogPoint', {
      text = '',
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = ''
    })
    vim.fn.sign_define('DapStopped',
      {
        text = '→',
        texthl = 'DapStopped',
        linehl = 'DapStopped',
        numhl = 'DapStopped'
      })

    keymaps.setup()
    langs.setup()
  end
}

return M
