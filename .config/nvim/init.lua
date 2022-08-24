local fn = vim.fn

if fn.exists("g:started_by_firenvim") == 1 then
  require "user.utils.globals"
  require "user.settings"
  require "user.colorscheme"
  -- Override some settings
  vim.opt.guifont = "FiraCode Nerd Font Mono:h12"
  vim.opt.laststatus = 0
  vim.opt.signcolumn = 'no'

  -- Options
  vim.g.firenvim_config = {
    globalSettigns = {
      ['alt'] = 'all',
      ['ignoreKeys'] = {},
    },
    localSettings = {
      [".*"] = {
        cmdline = 'neovim',
        content = 'text',
        priority = 0,
        selector = 'textarea',
        takeover = 'always'
      }
    }
  }
  us.set_keynomap("n", "<Esc>", "<cmd>call firenvim#hide_frame()|call firenvim#press_keys('<LT>Esc>')<cr>")
  -- us.set_keynomap("n", "<Esc>", "<cmd>wqall<cr>")
  vim.cmd [[
    au TextChanged * ++nested write
    au TextChangedI * ++nested write
  ]]
else
  if fn.exists("g:neovide") == 1 then
    -- https://neovide.dev/configuration.html
    -- vim.opt.guifont = "FiraCode Nerd Font:h6.9"
    vim.opt.guifont = "FiraCode Nerd Font Mono:h6.9"
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_profiler = false
    vim.g.neovide_input_use_logo = true
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animation_length = 0.0
    vim.g.neovide_cursor_trail_length = 0.18
    -- vim.g.neovide_window_floating_opacity = 0
    -- vim.g.neovide_window_floating_blur = 0
    vim.g.neovide_floating_opacity = 1
    -- vim.g.neovide_floating_blur = 0
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
  end
  -- require all
  require "user.utils.globals"
  require "user.settings"
  require "user.keymaps"
  require "user.colorscheme"
  require "user.plugins"
  require "user.autocmds"
  require "user.watch"
  -- SERVERS: "user.plugins.lsp.lsp_installer"
end
