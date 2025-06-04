local M = {
  "windwp/nvim-autopairs",
  event  = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")
    local autopairs_cmp = require('nvim-autopairs.completion.cmp')

    autopairs.setup({
      check_ts = true,
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })

    local cmp_status_ok, cmp = pcall(require, "cmp")
    if cmp_status_ok then
      cmp.event:on("confirm_done",
        autopairs_cmp.on_confirm_done()
      )
    end
  end
}

return M
