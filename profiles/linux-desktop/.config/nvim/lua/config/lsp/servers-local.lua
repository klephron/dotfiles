local M = {
  -- don't forget to vim.lsp.enable("mals") when needed
  mals = {
    root_dir = vim.fn.getcwd(),
    cmd = {
      "/home/klephron/.local/share/mise/installs/go/1.25.4/bin/mals-adapter",
      -- "-l",
      -- vim.fn.getcwd() .. "/mals-adapter.log",
      "-t",
      "localhost:9651",
      "-g",
      "3",
    },
  }
}

return M
