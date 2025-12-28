require("globals")

if config.profiles.scrollback then
  require("profiles.scrollback")
end

if config.profiles.firenvim then
  require("profiles.firenvim")
end

if config.profiles.neovide then
  require("profiles.neovide")
end

if config.profiles.vscode then
  require("profiles.vscode")
end

if config.profiles.default then
  require("profiles.default")
end

vim.lsp.enable("mals")
