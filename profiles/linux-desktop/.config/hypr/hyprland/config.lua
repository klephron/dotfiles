local local_ok, local_config = pcall(require, "hyprland.local")

local function wallpaper_video_source_get()
  local wallpaper = local_ok and local_config.wallpaper or {}
  local video = wallpaper.video or {}
  return video.source
end

local function wallpaper_video_enabled_get()
  local source = wallpaper_video_source_get()
  return source ~= nil and source ~= "" and true
end

local wallpaper_video_enabled = wallpaper_video_enabled_get()
local wallpaper_video_source = wallpaper_video_source_get()

return {
  colors = require("hyprland.colors.custom"),
  keyboard = {
    layout = table.concat({ "us", "ru" }, ","),
    options = table.concat({ "grp:alt_shift_toggle", "altwin:menu_win" }, ","),
  },
  wallpaper = {
    video = {
      enabled = wallpaper_video_enabled,
      source = wallpaper_video_source,
      audio = true,
    },
  }
}
