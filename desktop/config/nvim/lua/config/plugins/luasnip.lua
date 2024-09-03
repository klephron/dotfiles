local M = {
  "L3MON4D3/LuaSnip",
  enabled = true,
  lazy = true,
  dependencies = {
    "rafamadriz/friendly-snippets"
  },
  config = function()
    local luasnip = require("luasnip")
    local types = require("luasnip.util.types")
    local utils = require("utils.funcs")

    luasnip.setup({
      history = true,
      update_events = 'TextChanged,TextChangedI',
      region_check_events = 'CursorMoved,CursorMovedI',
      delete_check_events = "TextChanged",
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "●", "DiagnosticInfo" } },
          },
        },
      },
    })

    -- Load configured snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    -- require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/snipmate/" })
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/luasnip/" })


    utils.set_keynomap({ "i", "s" }, "<a-k>", function()
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      end
    end)
    utils.set_keynomap({ "i", "s" }, "<a-j>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end)

    vim.cmd("command! LuaSnipEdit :lua require('luasnip.loaders').edit_snippet_files()")
  end
}

return M
