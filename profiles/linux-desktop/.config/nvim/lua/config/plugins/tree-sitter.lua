local M;

M = {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local treesitter = require("nvim-treesitter")

    vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt.foldmethod = 'expr'

    treesitter.install(M.languages)
  end
}

M.languages = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "go",
  "gomod",
  "gosum",
  "haskell",
  "java",
  "javascript",
  "jinja",
  "json",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "ruby",
  "rust",
  "sql",
  "terraform",
  "toml",
  "vim",
  "yaml",
  "zig",
}

return M
