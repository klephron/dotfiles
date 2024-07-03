require("globals")

if config.is_neovide then
  preset_require("neovide")
end

if config.is_firenvim then
  preset_require("firenvim")
end

if config.is_vscode then
  preset_require("vscode-lazy")
end

if config.is_nvim then
  preset_require("nvim-lazy")
end
