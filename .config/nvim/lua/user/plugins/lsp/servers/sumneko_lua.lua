return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
