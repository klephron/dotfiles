local M = {
  "folke/trouble.nvim"
}

function M.config()
  local trouble = require("trouble")
  trouble.setup({
    use_diagnostic_signs = true,
    action_keys = {
      close = "Q",
    }
  })

  -- return focus to alternate buffer
  vim.cmd [[
    augroup _trouble
      au!
      au FileType Trouble nnoremap <buffer> q <cmd>silent! b #<cr><cmd>silent! TroubleClose<cr>
    augroup end
  ]]
end

return M
