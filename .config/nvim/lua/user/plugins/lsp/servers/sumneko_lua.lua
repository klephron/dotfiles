return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "use" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
