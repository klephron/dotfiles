local M = {
  state = {
    eventtap = nil,
    watcher = nil,
  },
}

function M.setNextLayout()
  local currentLayout = hs.keycodes.currentLayout()
  local layouts = hs.keycodes.layouts()
  if layouts and #layouts > 1 then
    local nextIndex = 1
    for i, layout in ipairs(layouts) do
      if layout == currentLayout then
        nextIndex = (i % #layouts) + 1
        break
      end
    end
    hs.keycodes.setLayout(layouts[nextIndex])
  end
end

function M.started()
  if M.state.eventtap then
    return true
  else
    return false
  end
end

function M.start()
  if M.started() then
    return
  end

  M.state.eventtap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
    local flags = event:getFlags()
    local pressed = false

    if flags.alt and flags.shift and not flags.cmd and not flags.ctrl then
      pressed = true
    end

    if pressed then
      M.setNextLayout()
    end
  end)

  if not M.state.eventtap then
    hs.alert.show("languagetogle: " .. "eventtap hasn't been created")
    return
  end

  M.state.watcher = hs.caffeinate.watcher.new(function(event)
    if event == hs.caffeinate.watcher.systemDidWake then
      M.state.eventtap:start()
    end
  end)

  if not M.state.watcher then
    hs.alert.show("languagetogle: " .. "watcher hasn't been created")
    return
  end

  M.state.eventtap:start()
  M.state.watcher:start()
end

function M.stop()
  if not M.started() then
    return
  end

  if M.state.watcher then
    M.state.watcher:stop()
    M.state.watcher = nil
  end

  if M.state.eventtap then
    M.state.eventtap:stop()
    M.state.eventtap = nil
  end
end

function M.toggle()
  if M.started() then
    M.stop()
  else
    M.start()
  end
end

return M
