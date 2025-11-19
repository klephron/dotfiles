local M = {
  "stevearc/aerial.nvim",
  cmd    = { "AerialToggle", "AerialOpen", "AerialClose" },
  config = function()
    local aerial = require("aerial")
    aerial.setup({
      backends = { "lsp", "treesitter", "markdown", "man" },

      layout = {
        max_width = { 40, 0.2 },
        min_width = { 20, 0.1 },

        default_direction = "prefer_right",
        placement = "edge",
      },

      attach_mode = "global",
      filter_kind = false,

      highlight_mode = "last",
      highlight_closest = true,
      highlight_on_hover = true,
      highlight_on_jump = 500,

      icons = require("config.icons").kind_icons,

      nerd_font = "auto",

      show_guides = true,
      guides = {
        mid_item = "├─",
        last_item = "└─",
        nested_top = "│ ", -- When there are nested child guides to the right
        whitespace = "  ",
      },
    })
  end,
  keys   = {
    { "<leader>at", "<cmd>AerialToggle!<cr>", desc = "Toggle symbol menu" },
    { "<leader>ao", "<cmd>AerialOpen<cr>",    desc = "Focus symbol focus" },
    { "<leader>ac", "<cmd>AerialClose<cr>",   desc = "Close symbol menu" }
  }
}

return M
