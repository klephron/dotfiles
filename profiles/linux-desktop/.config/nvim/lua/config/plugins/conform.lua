local M = {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "ConformToggle" },
  config = function()
    local conform = require("conform")

    conform.setup({
      default_format_opts = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      notify_on_error = true,
      notify_no_formatters = true,
      format_on_save = function(bufnr)
        if vim.b[bufnr].conform_disabled then
          return
        end
        if vim.g.conform_disabled then
          return
        end

        return {}
      end,
    })

    vim.api.nvim_create_user_command("ConformToggle", function(args)
      if args.bang then
        vim.g.conform_disabled = not vim.g.conform_disabled
        vim.notify(vim.g.conform_disabled and "disabled" or "enabled",
          vim.log.levels.INFO, { title = "format-on-save" }
        )
      else
        vim.b.conform_disabled = not vim.b.conform_disabled
        vim.notify("buffer " ..
          (vim.b.conform_disabled and "disabled" or "enabled"),
          vim.log.levels.INFO, { title = "format-on-save" }
        )
      end
    end, {
      desc = "Toggle format-on-save",
      bang = true,
    })
  end,
  keys = {
    {
      "<leader>km",
      function()
        require("conform").format({ async = true }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = "",
      desc = "Format buffer",
    },
    {
      "<localleader>km",
      "<cmd>ConformToggle!<cr>",
      mode = "n",
      desc = "Toggle format-on-save"
    },
    {
      "<localleader>kM",
      "<cmd>ConformToggle<cr>",
      mode = "n",
      desc = "Toggle buffer format-on-save"
    },
  },
}

return M;
