local M = {
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    }
  },

  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "black", "stylua"},
    }
  },
}

return M
