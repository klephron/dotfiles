local M = {
  'famiu/bufdelete.nvim',
  cmd = { "Bdelete" },
  keys = {
    { "<leader>f", "<cmd>Bdelete<cr>", desc = "Delete current buffer" },
  }
}

return M
