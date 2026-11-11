local function path_get()
  local pipe = io.popen("command -v mpvpaper 2>/dev/null")
  if not pipe then
    return nil
  end

  local path = pipe:read("*l")
  pipe:close()

  return path
end

local path = path_get()

local installed = (path ~= nil)

if not installed then
  hl.notification.create({ text = "[mpvpaper]: not installed", timeout = 2000 })
end

local function reload(config)
  if config.enabled and not installed then
    return
  end

  local stop =
      "if systemctl --user is-active --quiet mpvpaper.scope; then " ..
      "systemctl --user stop mpvpaper.scope; " ..
      "fi"

  if config.enabled then
    assert(path ~= nil)

    local exec = stop .. " && " ..
        "uwsm-app -s b -t scope -u mpvpaper.scope -- " ..
        "'" .. path:gsub("'", "'\\''") .. "' -o '" ..
        (config.audio and "" or "no-audio ") ..
        "loop-file=inf' ALL " ..
        "'" .. config.source:gsub("'", "'\\''") .. "'"

    hl.exec_cmd(exec)
  else
    hl.exec_cmd(stop)
  end
end


return {
  installed = installed,
  reload = reload,
  path = path,
}
