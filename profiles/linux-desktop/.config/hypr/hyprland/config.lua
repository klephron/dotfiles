local c = require("hyprland.common")
local u = require("hyprland.utils")

local lok, lconfig = pcall(require, "hyprland.local")

local function wallpaper_video_source_get()
  local wallpaper = lok and lconfig.wallpaper or {}
  local video = wallpaper.video or {}
  return video.source
end

local function wallpaper_video_ready_get()
  local source = wallpaper_video_source_get()
  return source ~= nil and source ~= ""
end

local function monitor_layout_name_get()
  local monitor = lok and lconfig and lconfig.monitor or {}
  local monitor_layout = monitor.layout or {}
  return monitor_layout.name
end

local wallpaper_video_ready = wallpaper_video_ready_get()
local wallpaper_video_source = wallpaper_video_source_get()
local monitor_layout_name = monitor_layout_name_get() or c.monitor.layouts.laptop

return {
  monitor = {
    layout = {
      name = monitor_layout_name,
      any = function(...)
        return u.contains({ ... }, monitor_layout_name)
      end,
    },
  },
  colors = require("hyprland.colors.custom"),
  keyboard = {
    layout = table.concat({ "us", "ru" }, ","),
    options = table.concat({ "grp:alt_shift_toggle", "altwin:menu_win" }, ","),
  },
  plugins = {
    mvpaper = {
      ready = wallpaper_video_ready,
      source = wallpaper_video_source,
    },
  }
}
