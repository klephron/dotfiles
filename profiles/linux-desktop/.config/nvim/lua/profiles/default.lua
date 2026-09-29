require("settings")
require("keymaps")
require("aliases")
require("autocmds")

require("profiles.common.lazy-bootstrap")

require("lazy").setup("plugins", {
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

require("colorscheme")
