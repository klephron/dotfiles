local M = {
  mals_lsp_adapter = {
    root_dir = vim.fn.getcwd(),
    cmd = {
      "/home/klephron/works/active/university-itmo/external/mals-lsp-adapter/build/adapter",
      "-l",
      "/home/klephron/works/active/university-itmo/external/mals-vscode/mals-lsp-adapter.log",
      "-t",
      "localhost:9651"
    },
  }
}

return M
