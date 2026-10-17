require("settings")
require("keymaps")
require("autocmds")
require("aliases")

require("profiles.common.lazy-bootstrap")

require("lazy").setup(
  {
    require("plugins.comment"),
    require("plugins.dial"),
    require("plugins.easy-align"),
    require("plugins.flash"),
    require("plugins.luasnip"),
    require("plugins.markdown-preview"),
    require("plugins.surround"),
    require("plugins.tree-sitter"),
    require("plugins.which-key"),
  }, {
    install = {},
    concurrency = vim.uv.available_parallelism() * 2,
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "nvim-treesitter-textobjects",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  }
)
