local M = {
  "ahmedkhalf/project.nvim"
}

function M.config()
  local project = require("project_nvim")
  local telescope = require("telescope")

  project.setup {
    manual_mode = true,
    detection_methods = { "lsp", "pattern" },
    patterns = {
      ".git", "_darcs", ".hg", ".bzr", "Makefile", "CMakeLists.txt", "package.json",
    },
    ignore_lsp = {},
    exclude_dirs = {},
    show_hidden = true,
    silent_chdir = true,
    datapath = vim.fn.expand(vim.fn.stdpath("cache")),
  }
  -- Add to telescope
  telescope.load_extension('projects')
end

return M
