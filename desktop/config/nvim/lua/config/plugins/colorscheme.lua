local M = {
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    -- enabled = false,
    lazy = true,
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
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = true,
    opts = {
      terminalColors = false,
      commentStyle = { italic = false },
    }
  }
}

return M
