-- lazy = false,    -- make sure we load this during startup if it is your main colorscheme
-- priority = 1000, -- make sure to load this before all the other start plugins

return {
  {
    "klephron/klephron-darker.nvim",
    dir = vim.env.NVIM_CONFIG_KLEPHRON_DARKER_DIR or nil,
    lazy = false,
    priority = 1000,
    opts = {
      bold = true,
      undercurl = true,
      underline = true,
      strikethrough = true,
      italic = {
        string = false,
        char = false,
        comment = false,
        operator = false,
        fold = false,
        text = false,
      },
    },
  }
}
