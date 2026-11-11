local fn = vim.fn
local env = vim.env

local utils = require("utils")

local local_ok, local_config = pcall(require, "local")

local function profile_get()
  local profile = env.NVIM_PROFILE

  if profile == nil or profile == '' then
    if env.KITTY_SCROLLBACK_NVIM == 'true' then
      profile = 'scrollback'
    elseif fn.exists('g:started_by_firenvim') == 1 then
      profile = 'firenvim'
    elseif fn.exists('g:neovide') == 1 then
      profile = 'neovide'
    elseif fn.exists('g:vscode') == 1 then
      profile = 'vscode'
    else
      profile = 'default'
    end
  end

  return profile
end

local function plugin_klephron_darker_dir_get()
  local plugin = local_ok and local_config.plugin or {}
  return plugin.klephron_darker_dir
    or vim.env.NVIM_CONFIG_KLEPHRON_DARKER_DIR
    or nil
end

local function plugin_watch_dir_get()
  local plugin = local_ok and local_config.plugin or {}
  return plugin.watch_dir
    or vim.env.NVIM_CONFIG_WATCH_DIR
    or nil
end


local profiles = {
  'basic',
  'default',
  'firenvim',
  'neovide',
  'scrollback',
  'vscode',
}

local profile_name = profile_get()


return {
  profile = {
    name = profile_name,
    valid = utils.contains(profiles, profile_name),
    available = profiles,
    contains = function(...)
      return utils.contains({ ... }, profile_name)
    end,
  },
  plugin = {
    klephron_darker_dir = plugin_klephron_darker_dir_get(),
    watch_dir = plugin_watch_dir_get(),
  }
}
