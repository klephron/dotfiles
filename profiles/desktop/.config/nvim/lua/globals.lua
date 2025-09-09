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
  is_scrollback = vim.env.KITTY_SCROLLBACK_NVIM == 'true'
}

_G.config.is_default = not (config.is_vscode or config.is_firenvim or config.is_neovide or config.is_scrollback)

table.unpack = table.unpack or unpack
