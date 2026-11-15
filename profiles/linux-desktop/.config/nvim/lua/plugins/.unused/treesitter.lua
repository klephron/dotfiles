return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",
  enabled = false,
  config = function()
    local config = require("config")
    local profiles = require("profiles")

    local ts_configs = require("nvim-treesitter.configs")

    ts_configs.setup({
      ensure_installed = {
      },
      highlight = {
        enable = config.profile.any(profiles.all.vscode) and false or true,
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
        enable = false,
        keymaps = {
          init_selection = "<A-o>",
          node_incremental = "<A-o>",
          node_decremental = "<A-i>",
        },
      },
    })
  end
}
