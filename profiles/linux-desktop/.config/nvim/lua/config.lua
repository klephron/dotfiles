local fn = vim.fn
local env = vim.env

local profiles = require("profiles")
local utils = require("utils")

local local_ok, local_config = pcall(require, "local")

local function profile_get()
  local profile = env.NVIM_PROFILE

  if profile == nil or profile == '' then
    if env.KITTY_SCROLLBACK_NVIM == 'true' then
      profile = profiles.all.scrollback
    elseif fn.exists('g:started_by_firenvim') == 1 then
      profile = profiles.all.firenvim
    elseif fn.exists('g:neovide') == 1 then
      profile = profiles.all.neovide
    elseif fn.exists('g:vscode') == 1 then
      profile = profiles.all.vscode
    else
      profile = profiles.all.default
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

local profile_name = profile_get()


return {
  profile = {
    name = profile_name,
    any = function(...)
      return utils.contains({ ... }, profile_name)
    end
  },
  plugins = {
    klephron_darker_dir = plugin_klephron_darker_dir_get(),
    watch_dir = plugin_watch_dir_get(),
  }
}
