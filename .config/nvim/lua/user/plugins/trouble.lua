local M = {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle" },
}

function M.config()
  local trouble = require("trouble")
  trouble.setup({
    use_diagnostic_signs = true,
    action_keys = {
      close = "Q"
    }
  })

  -- return focus to alternate buffer
  vim.cmd [[
    augroup _trouble
      au!
      au FileType Trouble nnoremap <buffer> q <CMD>lua vim.cmd('wincmd p')<CR><CMD>silent! TroubleClose<CR>
    augroup end
  ]]
end

return M
