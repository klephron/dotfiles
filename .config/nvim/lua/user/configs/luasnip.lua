local M = {}

function M.config()
  local ls = require("luasnip")
  local types = require("luasnip.util.types")

  -- Load configured snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/snipmate/" })
  require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/luasnip/" })

  ls.setup({
    history = true,
    update_events = 'TextChanged,TextChangedI',
    enable_autosnippets = true,
    delete_check_events = "TextChanged",
    -- store_selection_keys = "<Tab>",
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "●", "DiagnosticInfo" } },
        },
      },
      -- [types.insertNode] = {
      -- 	active = {
      -- 		virt_text = { { "●", "DiagnosticHint" } },
      -- 	},
      -- },
    },
  })

  us.set_keynomap({ "i", "s" }, "<a-k>", function()
    if ls.jumpable(1) then
      ls.jump(1)
    end
  end)
  us.set_keynomap({ "i", "s" }, "<a-j>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end)
end

return M
