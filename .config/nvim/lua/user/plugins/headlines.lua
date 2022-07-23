return function()
  local headlines_ok, headlines = safe_require("headlines")
  if not headlines_ok then
    return
  end

  headlines.setup {}
end
