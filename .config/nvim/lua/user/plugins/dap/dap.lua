local M = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
}


local function setup()
  local fn = vim.fn

  local function get_color(group, attr)
    return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
  end

  vim.api.nvim_set_hl(0, 'DapBreakpoint',
    { ctermbg = 0, fg = get_color("ErrorMsg", "fg"), bg = nil }
  )
  vim.api.nvim_set_hl(0, 'DapStopped',
    { ctermbg = 0, fg = nil, bg = "#022e4b" }
  )

  vim.fn.sign_define('DapBreakpoint',
    l
    { text = '',
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = ''
    })
  vim.fn.sign_define('DapBreakpointCondition',
    { text = 'ﳁ',
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = ''
    })
  vim.fn.sign_define('DapBreakpointRejected',
    { text = '',
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
    { text = '→',
      texthl = 'DapStopped',
      linehl = 'DapStopped',
      numhl = 'DapStopped'
    })
end

function M.config()
  local keymaps = conf_require("dap.sfn.keymaps")
  local langs = conf_require("dap.sfn.langs")

  setup()

  keymaps.setup()
  langs.setup()
end

return M
