local config = require("config")
local profiles = require("profiles")

if not config.profile.any(profiles.all.vscode) then
  -- vim.o.background = "light"
  vim.o.background = "dark"

  -- vim.cmd('colorscheme gruvbox-material')
  -- vim.cmd('colorscheme github_dark')
  -- vim.cmd("colorscheme kanagawa-wave")
  -- vim.cmd("colorscheme vscode")
  vim.cmd("colorscheme klephron-darker")
end
