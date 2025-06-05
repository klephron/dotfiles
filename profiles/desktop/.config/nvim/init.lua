require("globals")

if config.is_neovide then
  require("profiles.neovide")
end

if config.is_firenvim then
  require("profiles.firenvim")
end

if config.is_vscode then
  require("profiles.vscode-lazy")
end

if config.is_nvim then
  require("profiles.nvim-lazy")
  -- require("profiles.nvim-basic")
end

-- vim.lsp.enable("mals_lsp_adapter")
