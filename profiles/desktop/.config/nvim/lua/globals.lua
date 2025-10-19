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
    scrollback = env.KITTY_SCROLLBACK_NVIM == 'true'
  }
}

_G.config.profiles.default = not (
  config.profiles.vscode
  or config.profiles.firenvim
  or config.profiles.neovide
  or config.profiles.scrollback
)

local active = {}
for name, is_active in pairs(_G.config.profiles) do
  if is_active then
    table.insert(active, name)
  end
end
assert(#active <= 1, string.format("Multiple profiles active: %s", table.concat(active, ", ")))
