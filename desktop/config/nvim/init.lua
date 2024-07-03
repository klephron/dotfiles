require("user.utils.globals")

if us.is_neovide then
  vim.opt.guifont = "FiraCode Nerd Font Mono:h6.9"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_profiler = false
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animation_length = 0.0
  -- vim.g.neovide_window_floating_blur = 0
  vim.g.neovide_floating_opacity = 1
  -- vim.g.neovide_floating_blur = 0
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
end

if us.is_firenvim then
  require("user.settings")
  vim.notify("Using firenvim config", vim.log.levels.INFO, {})
  return
end

if us.is_vscode then
  require("user.settings")
  require("user.preset.vscode-lazy")
  require("user.keymaps")
  require("user.autocmds")
  require("user.aliases")
    vim.notify("Using vscode config", vim.log.levels.INFO, {})
  return
end

require("user.settings")
require("user.preset.nvim-lazy")
require("user.colorscheme")
require("user.keymaps")
require("user.aliases")
require("user.autocmds")

require("watch")
