local M = {
  "folke/noice.nvim",
  event = "UIEnter",
  cond = function() return vim.fn.exists("g:neovide") == 0 end,
}

function M.config()
  local focused = true
  us.augroup("noice_focus", {
    {
      event = "FocusGained",
      command = function()
        focused = true
      end
    },
    {
      event = "FocusLost",
      command = function()
        focused = false
      end
    }
  })

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
      long_message_to_split = false,
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
          min_length = 1, -- add everything
          -- any = {
          --   { event = "notify" },
          --   { error = true },
          --   { warning = true },
          --   { event = "msg_show", },
          --   { event = "lsp", kind = "message" },
          -- }
        }
      },
      all = {
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {},
      }
    },
    routes = {
      -- {
      --   filter = {
      --     cond = function() return not focused end,
      --   },
      --   view = "notify_send",
      --   opts = { stop = true },
      -- },
      { -- Disable neovim default notifications
        filter = {
          any = {
             { find = "--d+%--$" },
          },
          event = "msg_show",
          max_height = 1,
        },
        view = "mini",
        opts = { skip = true, replace = true, stop = true },
      },
      { -- Mini
        filter = {
          event = "lsp",
          kind = "progress",
        },
        view = "mini",
        opts = { skip = true, stop = true },
      },
      { -- One line info messages to mini
        filter = {
          any = {
            { max_height = 1 },
          },
          event = "notify",
          kind = "info"
        },
        view = "mini",
        opts = { skip = false, stop = true },
      },
      { -- Split
        filter = {
          any = {
            { min_height = 14 },
          },
        },
        view = "split",
        opts = { merge = true, enter = true, stop = true },
      }
    }
  })
end

return M
