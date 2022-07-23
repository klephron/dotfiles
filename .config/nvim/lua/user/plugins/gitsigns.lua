return function()
  local gitsigns = require("gitsigns")

  gitsigns.setup {
    signs = {
      add = { hl = 'GitSignsAdd', text = '▌' },
      change = { hl = 'GitSignsChange', text = '▌' },
      delete = { hl = 'GitSignsDelete', text = '契' },
      topdelete = { hl = 'GitSignsDelete', text = '契' },
      changedelete = { hl = 'GitSignsChange', text = '▌' },
    }
  }
end
