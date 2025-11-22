hs.hotkey.bind({ "cmd" }, "return", function()
  local appName = "Kitty"

  hs.execute("open -na '" .. appName .. "'")
end)

hs.hotkey.bind({ "cmd", "shift" }, "return", function()
  local appName = "Alacritty"

  hs.execute("open -na '" .. appName .. "'")
end)

hs.hotkey.bind({ "cmd" }, "b", function()
  local appName = "Firefox"
  local appMenu = { "File", "New Window" }

  local app = hs.application.find(appName)
  if app then
    app:selectMenuItem(appMenu)
  else
    hs.application.open(appName)
  end
end)

hs.hotkey.bind({ "cmd", "shift" }, "b", function()
  local appName = "Google Chrome"
  local appMenu = { "File", "New window" }

  local app = hs.application.find(appName)
  if app then
    app:selectMenuItem(appMenu)
  else
    hs.application.open(appName)
  end
end)
