local M = {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = function()
    local flash = require("flash")
    local funcs = require("utils.funcs")

    flash.setup({
      modes = {
        search = {
          enabled = false,
        },
        char = {
          enabled = true,
          autohide = true,
          jump_labels = true,
          multi_line = true,
          highlight = {
            -- https://github.com/folke/flash.nvim/issues/453
            -- Issue with multi_line = false
            backdrop = false,
          },
        },
        treesitter = {
          label = {
            style = "inline",
            before = true,
            after = true,
          },
          highlight = {
            backdrop = true,
          }
        },
        treesitter_search = {
          label = {
            style = "inline",
            before = true,
            after = true,
          }
        }
      },
      prompt = {
        enabled = false,
      }
    })

    funcs.set_keynomap({ "x", "n", "o" }, "s", function()
      flash.jump()
    end, "Flash multiline")

    funcs.set_keynomap({ "o", "x" }, "m", function()
      flash.treesitter()
    end, "Flash treesitter")

    funcs.set_keynomap({ "o", "x" }, "M",
      function()
        flash.treesitter_search()
      end, "Treesitter search")

    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ff007c", bold = true })
    vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#00dfff", bold = true })
    vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#2b8db3" })
    vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#666666" })
  end,
}

return M
