require("config.settings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local funcs = require("utils.funcs")

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

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

funcs.set_keynomap("n", "<localleader>z", "<cmd>Lazy<cr>", "Open lazy menu")

require("config.colorscheme")
require("config.keymaps")
require("config.aliases")
require("config.autocmds")

require("local.watch")
