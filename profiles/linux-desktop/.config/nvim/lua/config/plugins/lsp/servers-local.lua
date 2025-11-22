local M = {
  -- don't forget to vim.lsp.enable("mals_adapter") when needed
  mals_adapter = {
    root_dir = vim.fn.getcwd(),
    cmd = {
      "mals-adapter",
      "-l",
      vim.fn.getcwd() .. "/mals-adapter.log",
      "-t",
      "localhost:9651",
      "-g",
      "3",
    },
  }
}

return M
