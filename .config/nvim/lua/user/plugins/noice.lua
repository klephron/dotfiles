local M = {
  "folke/noice.nvim",
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
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
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
        view = "notify",
        filter = { event = "msg_showmode" },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
        },
        opts = { skip = false, merge = true, replace = true },
        view = "mini"
      },
    }
  })

  if not pcall(function() require("telescope").load_extension("noice") end) then
    vim.notify("module 'telescope' for noice.nvim is not present", vim.log.levels.WARN, { title = "config" })
  end
end

return M
