local c = require("hyprland.config")

local api = require("plugins.mvppaper")

local installed = api.installed

if not installed then
  hl.notification.create({ text = "[mpvpaper]: not installed", timeout = 2000 })
end

local function reload()
  if not installed then
    return
  end

  api.reload({
    enabled = c.plugins.mvpaper.ready and false,
    source = c.plugins.mvpaper.source,
    audio = true,
    panscan = 1,
  })
end

return {
  installed = installed,
  reload = reload,
}
