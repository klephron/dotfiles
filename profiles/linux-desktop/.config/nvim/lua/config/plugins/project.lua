local M = {
  "ahmedkhalf/project.nvim",
  cmd = { "ProjectRoot" },
  config = function()
    local project = require("project_nvim")

    project.setup {
      manual_mode = true,
      detection_methods = { "lsp", "pattern" },
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
      ignore_lsp = {},
      exclude_dirs = {},
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
