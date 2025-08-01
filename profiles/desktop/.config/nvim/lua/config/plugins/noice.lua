local M = {
  "folke/noice.nvim",
  event = "UIEnter",
  cond = function() return not config.is_neovide and not config.is_firenvim end,
  config = function()
    require("noice").setup({
      debug = false,
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false
        }
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      messages = {
        view = "mini",
        enabled = true,
      },
      commands = {
        history = {
          filter = {
            min_length = 1,
          }
        },
        all = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        }
      },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
        { -- Mini
          filter = {
            event = "lsp",
            kind = "progress",
          },
          view = "mini",
          opts = { skip = true, stop = true },
        },
        {
          filter = {
            event = "notify",
            kind = "info"
          },
          view = "mini",
          opts = { stop = true }
        }
      }
    })
  end,
  keys = {
    { "<localleader>lh", "<cmd>Noice history<cr>", desc = "Open noice history" },
    { "<localleader>ll", "<cmd>Noice last<cr>",    desc = "Open noice last" },
  }
}

return M
