return function()
  local status_ok, colorizer = us.safe_require("colorizer")
  if not status_ok then
    return
  end

  colorizer.setup(
    {
      'css',
      'javascript',
      'lua',
      html = { mode = 'background' }
    },
    {
      mode = 'background'
    })
end
