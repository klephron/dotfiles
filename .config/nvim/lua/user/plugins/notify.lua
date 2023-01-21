local M = {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
}

function M.config()
  local notify = require('notify')
  local renderer = require('notify.render')

  notify.setup {
    --stages = "fade_in_slide_out",
    timeout = 1000,
    fps = 30,
    level = vim.log.levels.INFO,
    max_width = function() return math.floor(vim.o.columns * 0.6) end,
    max_height = function() return math.floor(vim.o.lines * 0.6) end,
    render = function(bufnr, notif, highlights, config)
      local style = notif.title[1] == '' and 'minimal' or 'default'
      renderer[style](bufnr, notif, highlights, config)
    end,
  }

  -- Also: https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes
  vim.notify = notify
  require("telescope").load_extension("notify")
end

return M
