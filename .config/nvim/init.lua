local fn = vim.fn

-- Disable some builtin vim plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  -- "netrw",
  -- "netrwPlugin",
  -- "netrwSettings",
  -- "netrwFileHandlers",
  -- "matchit",
  -- "matchparen",
  "tar",
  "tutor_mode_plugin",
  "tarPlugin",
  "rrhelper",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
-----------------------------------------------------------------------------
-- FIRENVIM
-----------------------------------------------------------------------------
if fn.exists("g:started_by_firenvim") == 1 then
  require "user.utils.globals"
  require "user.settings"
  require "user.colorscheme"
  require "user.autocmds"
  require "user.aliases"
  -- Stop loading built in plugins
  vim.opt.guifont = "FiraCode Nerd Font Mono:h12"
  vim.opt.laststatus = 0
  vim.opt.signcolumn = 'no'
  -- -- Options
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
  us.set_keynomap("n", "<Esc>", "<cmd>wall | call firenvim#hide_frame() | call firenvim#press_keys('<LT>Esc>')<cr>")
  us.set_keynomap("n", "<leader>q", "<cmd>q<cr>")
  us.set_keynomap("n", "<leader>Q", "<cmd>qall<cr>")
  us.set_keynomap("n", "<leader>w", "<cmd>write<cr>")
  us.set_keynomap("n", "<leader>W", "<cmd>wall<cr>")
  -- vim.cmd [[
  --   au TextChanged * ++nested write
  --   au TextChangedI * ++nested write
  -- ]]
  -----------------------------------------------------------------------------
  -- NEOVIDE
  -----------------------------------------------------------------------------
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
  -----------------------------------------------------------------------------
  -- STANDARD
  -----------------------------------------------------------------------------
  require("user.utils.globals")
  require("user.settings")
  require("user.keymaps")
  require("user.colorscheme")
  require("user.confs") -- configurations for plugins
  require("user.autocmds")
  require("user.aliases")
  -- Load custom plugins
  require("watch") -- custom plugins
  -- SERVERS: "user.plugins.lsp.lsp_installer"
end
