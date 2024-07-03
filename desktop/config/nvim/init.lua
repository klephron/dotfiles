require("config.globals")

if config.is_neovide then
  require("presets.neovide")
end

if config.is_firenvim then
  require("presets.firenvim")
end

if config.is_vscode then
  require("presets.vscode-lazy")
end

if config.is_nvim then
  require("presets.nvim-lazy")
end
