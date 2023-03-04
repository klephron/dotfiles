local fn = vim.fn

if fn.exists("g:started_by_firenvim") == 1 then
  require("user.settings")
  require("user.utils.globals")
  require("user.keymaps")
  require("user.autocmds")
  return
end

if fn.exists("g:neovide") == 1 then
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


require("user.settings")
require("user.utils.globals")
require("user.colorscheme")
require("user.lazy")
require("user.keymaps")
require("user.autocmds")

-- watch personal module
require("watch")
