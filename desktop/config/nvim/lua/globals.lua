local fmt = string.format
local fn = vim.fn

_G.config = {
  prefix = {
    config = "config",
    plugins = "config.plugins",
    presets = "presets",
    utils = "utils",
    _local = "local",
  },
  is_vscode = fn.exists("g:vscode") == 1,
  is_firenvim = fn.exists("g:started_by_firenvim") == 1,
  is_neovide = fn.exists("g:neovide") == 1,
}
_G.config.is_nvim = not (config.is_vscode or config.is_firenvim or config.is_neovide)

table.unpack = table.unpack or unpack
