require("config.utils.globals")


if config.is_neovide then
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

if config.is_firenvim then
  require("config.settings")
  vim.notify("Using firenvim config", vim.log.levels.INFO, {})
  return
end

if config.is_vscode then
  require("config.settings")
  require("config.preset.vscode-lazy")
  require("config.keymaps")
  require("config.autocmds")
  require("config.aliases")
    vim.notify("Using vscode config", vim.log.levels.INFO, {})
  return
end


require("config.settings")


require("config.preset.nvim-lazy")
require("config.colorscheme")
require("config.keymaps")
require("config.aliases")
require("config.autocmds")

require("watch")
