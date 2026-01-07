require("config.settings")

require("profiles.bootstrap.lazy")
require("lazy").setup(
  {
    require("config.plugins.comment"),
    require("config.plugins.dial"),
    require("config.plugins.hop"),
    require("config.plugins.luasnip"),
    require("config.plugins.markdown-preview"),
    require("config.plugins.surround"),
    require("config.plugins.which-key"),
    require("config.plugins.treehopper"),
    require("config.plugins.treesitter"),
    require("config.plugins.easy-align"),
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
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
          "nvim-treesitter-textobjects",
        },
      },
    },

  })

require("config.keymaps")
require("config.autocmds")
require("config.aliases")
