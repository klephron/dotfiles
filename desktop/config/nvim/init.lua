require("config.globals")

if config.is_neovide then
  require("presets.neovide")
  return
end

if config.is_firenvim then
  require("presets.firenvim")
  return
end

if config.is_vscode then
  require("presets.vscode-lazy")
  return
end

require("presets.nvim-lazy")
