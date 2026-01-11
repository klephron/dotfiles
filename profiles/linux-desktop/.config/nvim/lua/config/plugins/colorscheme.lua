local M = {
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    -- enabled = false,
    lazy = true,
    enabled = false,
    opts = {
      transparent = false,
      group_overrides = {
        -- Hop
        HopNextKey = { fg = '#ff007c', bg = 'NONE', bold = true },
        HopNextKey1 = { fg = '#00dfff', bg = 'NONE', bold = true },
        HopNextKey2 = { fg = '#2b8db3', bg = 'NONE', bold = true },
        HopUnmatched = { fg = "#808080", bg = 'NONE' },
        HopCursor = { link = "Cursor" },
        HopPreview = { link = "IncSearch" },
        -- Treehopper
        TSNodeUnmatched = { link = "HopUnmatched" },
        TSNodeKey = { link = "HopNextKey" },
      }
    }
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
    end
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    enabled = false,
    config = function()
      require('github-theme').setup({
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = true,
    enabled = true,
    opts = {
      terminalColors = false,
      commentStyle = { italic = false },
    }
  },
  {
    "blazkowolf/gruber-darker.nvim",
    config = function()
      local colorscheme = require("gruber-darker")

      colorscheme.setup({
        bold = true,
        italic = {
          strings = false,
          comments = false,
        },
      })

      local override = function()
        vim.api.nvim_set_hl(0, "@property", { link = "@field" })
        vim.api.nvim_set_hl(0, "@variable.field", { link = "@variable" })
        vim.api.nvim_set_hl(0, "@variable.member", { link = "@variable" })
        vim.api.nvim_set_hl(0, "@module", { link = "@variable" })
        vim.api.nvim_set_hl(0, "DiagnosticInfo", { link = "GruberDarkerNiagara" })
        vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { link = "GruberDarkerNiagaraSign" })
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "gruber-darker",
        callback = override,
      })
    end,
  },
  {
    dir = vim.fn.expand("$HOME/works/darkplus.nvim"),
    config = function()
    end,
  }
}

return M
