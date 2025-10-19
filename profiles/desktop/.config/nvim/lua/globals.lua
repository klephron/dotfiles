local fn = vim.fn
local env = vim.env

_G.config = {
  paths = {
    ["config"] = "config",
    ["plugins"] = "config.plugins",
    ["presets"] = "presets",
    ["utils"] = "utils",
    ["local"] = "local",
  },
  is_vscode = fn.exists("g:vscode") == 1,
  is_firenvim = fn.exists("g:started_by_firenvim") == 1,
  is_neovide = fn.exists("g:neovide") == 1,
  is_scrollback = env.KITTY_SCROLLBACK_NVIM == 'true'
}
