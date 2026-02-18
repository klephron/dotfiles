require("config.settings")

require("profiles.bootstrap.lazy")
require("lazy").setup({
  require("config.plugins.snacks"),
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

require("config.colorscheme")
require("config.keymaps")
require("config.aliases")
require("config.autocmds")
