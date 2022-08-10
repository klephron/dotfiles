return function()
  local gitsigns = require("gitsigns")
  local icons = require("user.icons").gitsigns

  gitsigns.setup {
    signs = {
      add = { hl = 'GitSignsAdd', text = icons.add },
      change = { hl = 'GitSignsChange', text = icons.change },
      delete = { hl = 'GitSignsDelete', text = icons.delete },
      topdelete = { hl = 'GitSignsDelete', text = icons.topdelete },
      changedelete = { hl = 'GitSignsChange', text = icons.changedelete },
    }
  }
end
