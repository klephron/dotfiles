local M = {
  "DrKJeff16/project.nvim",
  cmd = { "ProjectRoot" },
  config = function()
    local project = require("project")

    project.setup {
      manual_mode = true,
      lsp =  {
        enabled = true,
        ignore = {},
      },
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        "Makefile",
        "CMakeLists.txt",
        "package.json",
        "Cargo.toml",
      },
      exclude_dirs = {},
      enable_autochdir = false,
      show_hidden = true,
      silent_chdir = true,
      datapath = vim.fn.expand(vim.fn.stdpath("cache")),
    }
  end,
  keys = {
    { "<leader>P", "<cmd>Telescope projects<cr>", desc = "List projects" },
    { "<leader>p", "<cmd>ProjectRoot<cr>",        desc = "Update root" },
  }
}

return M
