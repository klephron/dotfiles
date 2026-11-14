return {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = function()
    local flash = require("flash")
    local utils = require("utils")

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

    utils.set_keynomap({ "x", "n", "o" }, "s", function()
      flash.jump()
    end, "[flash] Multiline")

    utils.set_keynomap({ "o", "x" }, "m", function()
      flash.treesitter()
    end, "[flash] Treesitter")

    utils.set_keynomap({ "o", "x" }, "M",
      function()
        flash.treesitter_search()
      end, "[flash] Treesitter search")

    utils.set_keynomap({ "n", "x", "o" }, "<A-o>",
      function()
        require("flash").treesitter({
          label = {
            after = true,
            before = true,
          },
          highlight = {
            backdrop = false,
            matches = false,
          },
          actions = {
            ["<A-o>"] = "next",
            ["<A-i>"] = "prev"
          }
        })
      end, { desc = "[flash] Treesitter incr selection" })

    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ff007c", bold = true })
    vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#00dfff", bold = true })
    vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#2b8db3" })
    vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#666666" })
  end,
}
