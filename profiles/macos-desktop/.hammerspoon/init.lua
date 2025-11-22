hs.hotkey.bind({ "cmd" }, "return", function()
  hs.execute('open -na "kitty"')
end)

hs.hotkey.bind({ "cmd", "shift" }, "return", function()
  hs.execute('open -na "alacritty"')
end)

-- hs.hotkey.bind({ "cmd" }, "c", function()
--   hs.execute('open -na "Firefox"')
-- end)

-- hs.hotkey.bind({ "cmd", "shift" }, "c", function()
--   hs.execute('open -na "Google Chrome"')
-- end)
