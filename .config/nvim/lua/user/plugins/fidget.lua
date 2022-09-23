return function()
  local fidget = require("fidget")

  fidget.setup {
    text = {
      spinner = "dots",
    },
    window = {
      relative = "editor",
    },
    timer = {
      task_decay = 0,
    },
  }
end
