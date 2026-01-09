local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",
  config = function()
    local ts_configs = require("nvim-treesitter.configs")

    local ensure_installed = {
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
      "jsonc",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "norg",
      "python",
      "regex",
      "ruby",
      "rust",
      "sql",
      "terraform",
      "toml",
      "verilog",
      "vim",
      "yaml",
    }

    ts_configs.setup({
      ensure_installed = ensure_installed,
      highlight = {
        enable = config.is_vscode and false or true,
        -- enable = false,
      },
      indent = {
        enable = false,
      },
      context_commentstring = {
        enable_autocmd = false,
      },
      sync_install = false,
      auto_install = false,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<A-o>",
          node_incremental = "<A-o>",
          node_decremental = "<A-i>",
        },
      },
    })
  end
}

return M
