c_require("settings")

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
  p_require("hop"),
  p_require("vim-easy-align"),
  p_require("markdown-preview"),
  p_require("nvim-surround"),
  p_require("which-key"),
  p_require("comment"),
  p_require("dial"),
  p_require("luasnip"),
  p_require("treesitter"),
  p_require("treehopper")
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

l_require("keymaps")
l_require("autocmds")
l_require("aliases")

vim.notify("Using vscode config", vim.log.levels.INFO, {})
