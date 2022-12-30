local M = {
  "folke/noice.nvim",
  enabled = true,
  config = {}
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
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = false,
      inc_rename = false,
      lsp_doc_border = false,
    },
    messages = {
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
      {
        filter = {
          cond = function() return not focused end,
        },
        view = "notify_send",
        opts = { stop = false },
      },
      {
        filter = {
          any = {
            { find = "%d+L, %d+B$" },
            { find = "^Already at oldest change" },
            { find = "^Already at newest change" },
            { find = "^%d+ change" },
            { find = "^%d+ lines <ed" },
            { find = "^%d+ lines >ed" },
            { find = "^%d+ fewer line" },
            { find = "^%d+ more line" },
            { find = "^%d+ fewer line" },
            { find = "^%d+ lines yanked" },
          },
          event = "msg_show",
          max_height = 1,
        },
        view = "mini",
      },
      {
        filter = {
          any = {
            { min_height = 14 },
            { min_width = 120 },
          }
        },
        view = "split",
        opts = { merge = true, enter = true },
      }
    }
  })
  require("telescope").load_extension("noice")
end

return M
