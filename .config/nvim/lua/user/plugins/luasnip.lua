return function()
  local ls = require("luasnip")

  -- Load configured snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/luasnip/"})

end
