local config = {
  settings = {
    Lua = {
      runtime = {
        special = {
          ["safe_require"] = "require"
        }
      },
      diagnostics = {
      },
      completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
    },
  }
}


local ok, lua_dev = safe_require('lua-dev')
if not ok then
  return config
end

config = lua_dev.setup({
  lspconfig = config
})
-- register config path
table.insert(config.settings.Lua.workspace.library, vim.fn.expand("$HOME/.config/nvim/lua"))
-- print(us.dump_lua_table(config))
return config

