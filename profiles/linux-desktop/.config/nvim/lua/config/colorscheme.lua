if config.is_vscode then
  return
end

-- vim.cmd("colorscheme kanagawa-wave")
-- vim.cmd.colorscheme('gruvbox-material')
-- vim.cmd('colorscheme github_dark')

vim.cmd("colorscheme gruber-darker")
vim.api.nvim_set_hl(0, "DiagnosticInfo", { link = "GruberDarkerNiagara" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { link = "GruberDarkerNiagaraSign" })
