require("globals")

if config.is_scrollback then
  require("profiles.scrollback")
  return
end

if config.is_firenvim then
  require("profiles.firenvim")
  return
end

if config.is_neovide then
  require("profiles.neovide")
  return
end

if config.is_vscode then
  require("profiles.vscode")
  return
end

require("profiles.default")
