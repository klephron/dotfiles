return function()
  -- Setup nvim-cmp.
  local autopairs = require("nvim-autopairs")

  autopairs.setup {
    disable_filetype = { "TelescopePrompt", },

    check_ts = true,
    ts_config = {
      lua = { "string" },
      javascript = { "template_string" },
    },

    fast_wrap = {
      map = '<M-e>',
      end_key = 'L',
      highlight = 'HopNextKey',
    },

  }

  local handlers = require('nvim-autopairs.completion.handlers')

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp_status_ok, cmp = safe_require("cmp")
  if not cmp_status_ok then
    return
  end
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
      ["*"] = {
        ['('] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
          },
          -- NOTE: Inpect with print(vim.inspect{char, item, bufnr, commit_character})
          handler = function(char, item, bufnr, commit_character)
            vim.notify(vim.inspect { char, item, bufnr, commit_character })
          end,
          -- handler = handlers["*"]
        }
      },
    })
  )
end
