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

local installed = path ~= nil

---@class MpvpaperConfig
---@field audio boolean
---@field enabled boolean
---@field panscan integer
---@field source string

---@param config MpvpaperConfig
local function reload(config)
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
        "panscan=" .. tostring(config.panscan) .. " " ..
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
}
