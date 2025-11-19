local fn = vim.fn
local env = vim.env

_G.config = {
  paths = {
    config = "config",
    plugins = "config.plugins",
    presets = "presets",
    utils = "utils",
    locals = "locals",
  },
  profiles = {
    vscode = fn.exists("g:vscode") == 1,
    firenvim = fn.exists("g:started_by_firenvim") == 1,
    neovide = fn.exists("g:neovide") == 1,
    scrollback = env.KITTY_SCROLLBACK_NVIM == 'true',
    default = nil,
  }
}

_G.config.profiles.default = not (
  config.profiles.vscode
  or config.profiles.firenvim
  or config.profiles.neovide
  or config.profiles.scrollback
)

_G.profiles_any = function(...)
  for i = 1, select('#', ...) do
    local name = select(i, ...)
    if _G.config.profiles[name] then
      return true
    end
  end
end

local active = {}
for name, is_active in pairs(_G.config.profiles) do
  if is_active then
    table.insert(active, name)
  end
end
assert(#active <= 1, string.format("Multiple profiles active: %s", table.concat(active, ", ")))

table.unpack = table.unpack or unpack
