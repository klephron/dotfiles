local ok, neodev = safe_require('neodev')
if ok then neodev.setup({
    override = function(root_dir, options) end,
  })
end

-- register config path
-- table.insert(config.settings.Lua.workspace.library, vim.fn.expand("$HOME/.config/nvim/lua"))
-- print(us.dump_lua_table(config))

return {
  settings = {
    Lua = {
      runtime = {
        special = {
          ["safe_require"] = "require",
          ["conf"] = "require"
        }
      },
      diagnostics = {},
      completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
    },
  }
}
