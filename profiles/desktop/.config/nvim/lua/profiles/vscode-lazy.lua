require("config.settings")

-- bootstrap from github
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "git@github.com:folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  require("config.plugins.hop"),
  require("config.plugins.vim-easy-align"),
  require("config.plugins.markdown-preview"),
  require("config.plugins.surround"),
  require("config.plugins.which-key"),
  require("config.plugins.comment"),
  require("config.plugins.dial"),
  require("config.plugins.luasnip"),
  require("config.plugins.treesitter"),
  require("config.plugins.treehopper")
}
, {
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

vim.notify("Using vscode config", vim.log.levels.INFO, {})
