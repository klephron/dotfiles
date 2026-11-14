return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "ConformToggle" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        ["*"] = { "trim_whitespace" },
      },
      default_format_opts = {
        timeout_ms = 500,
        lsp_format = "first",
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

    vim.g.conform_disabled = false

    vim.api.nvim_create_user_command("ConformToggle", function(args)
      if args.bang then
        vim.g.conform_disabled = not vim.g.conform_disabled
        vim.notify(vim.g.conform_disabled and "disabled" or "enabled",
          vim.log.levels.INFO, { title = "[conform] format-on-save" }
        )
      else
        vim.b.conform_disabled = not vim.b.conform_disabled
        vim.notify("buffer " ..
          (vim.b.conform_disabled and "disabled" or "enabled"),
          vim.log.levels.INFO, { title = "[conform] format-on-save" }
        )
      end
    end, {
      desc = "[conform] Toggle format-on-save",
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
      desc = "[conform] Format buffer",
    },
    {
      "<leader>kt",
      function()
        require("conform").format({
          async = true,
          formatters = { "trim_whitespace" },
          lsp_format = "never",
        }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = "",
      desc = "[conform] Trim buffer whitespace",
    },
    {
      "<localleader>km",
      "<cmd>ConformToggle!<cr>",
      mode = "n",
      desc = "[conform] Toggle format-on-save global"
    },
    {
      "<localleader>kM",
      "<cmd>ConformToggle<cr>",
      mode = "n",
      desc = "[conform] Toggle format-on-save buffer"
    },
  },
}
