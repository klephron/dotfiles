local M = {
  "romus204/tree-sitter-manager.nvim",
  dependencies = {}, -- tree-sitter CLI must be installed system-wide
  event = "VeryLazy",
  config = function()
    local treesitter = require("tree-sitter-manager")
    local funcs = require("utils.funcs")

    treesitter.setup({
      ensure_installed = {
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
      },
      border = "single",
      auto_install = false,
      highlight = true,
    })

    funcs.set_keynomap("n", "<localleader>ti", "<cmd>TSManager<cr>", "Open tree-sitter-manager")
  end,
}

return M
