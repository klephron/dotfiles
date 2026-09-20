local M;

M = {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local treesitter = require("nvim-treesitter")
    local funcs = require("utils.funcs")

    funcs.augroup("p.treesitter", {
      {
        event = "FileType",
        pattern = M.languages,
        command = function()
          vim.treesitter.start()
          -- folds, provided by Neovim
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo.foldmethod = 'expr'
          -- indentation, provided by nvim-treesitter
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      }
    })

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
