local config = require("config")

return {
  "folke/noice.nvim",
  event = "UIEnter",
  cond = function() return not config.profile.contains("vscode", "firenvim") end,
  config = function()
    local noice = require("noice")

    noice.setup({
      debug = false,
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      views = {
        mini = {
          format = { "{title} ", "{message}" },
        },
      },
      messages = {
        enabled = true,
        view = "mini",
        view_search = "virtualtext",
      },
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
        },
      },
      routes = {
        {
          filter = { event = "msg_showmode" },
          view = "notify",
        },
        {
          filter = {
            event = "lsp",
            kind = "progress",
          },
          opts = { skip = true, stop = true },
          view = "mini",
        },
        {
          filter = {
            event = "notify",
            kind = { "info", "debug" },
          },
          opts = { stop = true },
          view = "mini",
        },
      },
    })
  end,
  keys = {
    { "<localleader>lm", "<cmd>messages<cr>",      desc = "[nvim] Messages" },
    { "<localleader>lh", "<cmd>Noice history<cr>", desc = "[noice] Open history" },
    { "<localleader>la", "<cmd>Noice all<cr>",     desc = "[noice] Open all" },
    { "<localleader>ll", "<cmd>Noice last<cr>",    desc = "[noice] Open last" },
  }
}
