local M = {
  'famiu/bufdelete.nvim',
  cmd = { "Bdelete" },
  keys = {
    { "<leader>f", "<cmd>Bdelete<cr>", desc = "buf: Delete current" },
  }
}

return M
