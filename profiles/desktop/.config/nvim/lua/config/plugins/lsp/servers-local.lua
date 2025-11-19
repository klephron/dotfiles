local M = {
  -- don't forget to vim.lsp.enable("mals_lsp") when needed
  mals_lsp = {
    root_dir = vim.fn.getcwd(),
    cmd = {
      "mals-lsp",
      "-l",
      vim.fn.getcwd() .. "/mals-lsp.log",
      "-t",
      "localhost:9651",
      "-g",
      "3",
    },
  }
}

return M
