local M = {
  "L3MON4D3/LuaSnip",
  lazy = true,
  dependencies = {
    "rafamadriz/friendly-snippets"
  },
  config = function()
    local luasnip = require("luasnip")
    local types = require("luasnip.util.types")

    -- Load configured snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    -- require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/snipmate/" })
    -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/luasnip/" })

    luasnip.setup({
      history = true,
      update_events = 'TextChanged,TextChangedI',
      region_check_events = 'CursorMoved',
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "●", "DiagnosticInfo" } },
          },
        },
      },
    })

    us.set_keynomap({ "i", "s" }, "<a-k>", function()
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      end
    end)
    us.set_keynomap({ "i", "s" }, "<a-j>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end)
  end
}

return M
