return function()
  local neorg_ok, neorg = safe_require("neorg")
  if not neorg_ok then
    return
  end

  neorg.setup {
    ['core.defaults'] = {},
  }
end
