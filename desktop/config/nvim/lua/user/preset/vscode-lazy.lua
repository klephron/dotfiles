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
  require("user.plugins.hop"),
  require("user.plugins.vim-easy-align"),
  require("user.plugins.markdown-preview"),
  require("user.plugins.nvim-surround"),
  require("user.plugins.which-key"),
  require("user.plugins.comment"),
  require("user.plugins.dial"),
  require("user.plugins.luasnip"),
}
, {
  install = {},
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
