require("config.settings")

require("profiles.bootstrap.lazy")
require("lazy").setup(
  {
    require("config.plugins.autopairs"),
    require("config.plugins.cmp"),
    require("config.plugins.colorscheme"),
    require("config.plugins.comment"),
    require("config.plugins.dial"),
    require("config.plugins.hop"),
    require("config.plugins.kitty-scrollback"),
    require("config.plugins.luasnip"),
    require("config.plugins.markdown-preview"),
    require("config.plugins.noice"),
    require("config.plugins.snacks"),
    require("config.plugins.surround"),
    require("config.plugins.treehopper"),
    require("config.plugins.treesitter"),
    require("config.plugins.vim-easy-align"),
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
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
          "nvim-treesitter-textobjects",
        },
      },
    },
  })

require("config.colorscheme")
require("config.keymaps")
require("config.aliases")
require("config.autocmds")
