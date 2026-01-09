local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets"
  },
  lazy = true,
  config = function()
    local luasnip = require("luasnip")
    local types = require("luasnip.util.types")
    local funcs = require("utils.funcs")

    luasnip.setup({
      keep_roots = false,
      link_roots = false,
      link_children = false,
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

    funcs.set_keynomap({ "i", "s" }, "<a-k>", function()
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      end
    end)
    funcs.set_keynomap({ "i", "s" }, "<a-j>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end)

    vim.cmd("command! LuaSnipEdit :lua require('luasnip.loaders').edit_snippet_files()")

    funcs.set_keynomap("n", "<localleader>s", "<cmd>LuaSnipEdit<cr>", "Edit snippets")
  end,
}

return M
