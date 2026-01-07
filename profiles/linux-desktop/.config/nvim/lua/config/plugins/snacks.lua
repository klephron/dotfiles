local M = {
  "folke/snacks.nvim",
  enabled = true,
  opts = {
    input = {
      keys = {
        --   n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
        i_esc = { "<esc>", { "stopinsert" }, mode = "i", expr = true },
        --   i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
        --   i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
        --   i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
        --   i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
        --   i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
        --   q = "cancel",
      },
    },
    -- NOTE: maybe replace dressing later?
    notifier = {
    },
    notify = {
    },
    indent = {
      scope = {
        enabled = false,
      }
    }
  }
}

return M
