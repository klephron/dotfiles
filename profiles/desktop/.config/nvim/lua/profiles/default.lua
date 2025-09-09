require("config.settings")

require("profiles.bootstrap.lazy-nvim")
require("lazy").setup(config.prefix.plugins, {
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

require("local.watch")
