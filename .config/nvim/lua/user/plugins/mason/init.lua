local M = {
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
      dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
      }
    }
  },

  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "black", "stylua" },
    },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    }
  },
}

return M
