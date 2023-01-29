local M = {
  "ahmedkhalf/project.nvim",
  cmd = { "ProjectRoot" },
  enable = false,
}

function M.config()
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
end

return M
