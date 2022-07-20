return function()
  local notify_ok, notify = safe_require('notify')
  if not notify_ok then
    return
  end
  local renderer = require('notify.render')

  notify.setup {
    stages = "fade_in_slide_out",
    timeout = 1000,
    max_width = function() return math.floor(vim.o.columns * 0.6) end,
    max_height = function() return math.floor(vim.o.lines * 0.6) end,
    render = function(bufnr, notif, highlights, config)
      local style = notif.title[1] == '' and 'minimal' or 'default'
      renderer[style](bufnr, notif, highlights, config)
    end,
  }

  -- TODO: implement this for LSP: https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes
  vim.notify = notify
  require("telescope").load_extension("notify")
end
