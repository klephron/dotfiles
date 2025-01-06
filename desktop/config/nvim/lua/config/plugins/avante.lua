local M = {
  "yetone/avante.nvim",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  event = "VeryLazy",
  build = "make",
  lazy = false,
  version = "*",
  enabled = true,
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    mappings = {
      ask = "<leader>oa",
      edit = "<leader>oe",
      refresh = "<leader>or",
      focus = "<leader>of",
      toggle = {
        default = "<leader>ot",
        debug = "<leader>od",
        hint = "<leader>oh",
        suggestion = "<leader>os",
        repomap = "<leader>oR",
      },
      sidebar = {
      },
    },
    hints = {
      enabled = false,
    }
  },
}

return M
