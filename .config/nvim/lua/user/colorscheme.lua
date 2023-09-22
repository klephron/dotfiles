if us.is_vscode or us.is_neovide then
  return
end

-- local colorscheme = "darkplus"
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

-- vscode.nvim
-- require("vscode").load("dark")

vim.cmd("colorscheme kanagawa")
