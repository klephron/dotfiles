require("settings")
require("keymaps")
require("aliases")
require("autocmds")

require("profiles.common.lazy-bootstrap")

require("lazy").setup(
  {
    require("plugins.INIT"),
    require("plugins.COLORSCHEME"),
    require("plugins.autopairs"),
    require("plugins.cmp"),
    require("plugins.colorizer"),
    require("plugins.comment"),
    require("plugins.dial"),
    require("plugins.easy-align"),
    require("plugins.flash"),
    require("plugins.kitty-scrollback"),
    require("plugins.luasnip"),
    require("plugins.marks"),
    require("plugins.noice"),
    require("plugins.snacks"),
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

require("colorscheme")
