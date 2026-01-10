require("config.settings")

require("profiles.bootstrap.lazy")
require("lazy").setup(
  {
    require("config.plugins.comment"),
    require("config.plugins.dial"),
    require("config.plugins.easy-align"),
    require("config.plugins.flash"),
    require("config.plugins.luasnip"),
    require("config.plugins.markdown-preview"),
    require("config.plugins.surround"),
    require("config.plugins.treesitter"),
    require("config.plugins.which-key"),
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

  })

require("config.keymaps")
require("config.autocmds")
require("config.aliases")
