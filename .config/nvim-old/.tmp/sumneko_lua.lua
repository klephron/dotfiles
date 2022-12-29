-- put this file somewhere in your nvim config, like: ~/.config/nvim/lua/config/lua-lsp.lua
-- usage: require'lspconfig'.sumneko_lua.setup(require("config.lua-lsp"))

local library = {}

local path = vim.split(package.path, ";")
table.insert(path, "lua/?.lua")
table.insert(path, "lua/?/init.lua")

local function add_lib(lib)
  for _, p in pairs(vim.fn.expand(lib, false, true)) do
    p = vim.loop.fs_realpath(p)
    library[p] = true
  end
end

-- add runtime
add_lib("$VIMRUNTIME")
-- add your config
add_lib("~/.config/nvim")
-- add plugins
add_lib("~/.local/share/nvim/site/pack/packer/opt/*")
add_lib("~/.local/share/nvim/site/pack/packer/start/*")

-- remove relative path
local function remove_path(pe)
  for k, v in ipairs(path) do
    if v == pe then
      table.remove(path, k)
      break
    end
  end
end

-- remove relative path
remove_path("./?.lua")

return {
  --[[ -- delete root from workspace to make sure we don't trigger duplicate warnings
  on_new_config = function(config, root)
    local libs = vim.tbl_deep_extend("force", {}, library)
    libs[root] = nil
    config.settings.Lua.workspace.library = libs
    -- print(us.dump_lua_table(config))
    return config
  end, ]]
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = path
      },
      completion = { callSnippet = "Both" },
      diagnostics = {
        -- globals = { "vim" }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = library,
        -- maxPreload = 10000,
        -- preloadFileSize = 50000
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false }
    }
  }
}
