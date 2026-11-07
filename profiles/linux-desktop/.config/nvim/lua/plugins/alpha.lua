return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local theme = require("alpha.themes.dashboard")
    local icons = require("icons").alpha

    local header = {
      type = "text",
      val = theme.section.header.val,
      opts = {
        position = "center",
        hl = "Character"
      }
    }
    local buttons = {
      type = "group",
      val = {
        theme.button("e", icons.File .. " Plain file", "<cmd>ene<cr>"),
        theme.button("c", icons.Settings .. " Edit config", "<cmd>e $MYVIMRC<cr><cmd>Project! root<cr>"),

        theme.button("v", icons.Reference .. " Restore current session", "<cmd>PossessionLoad<cr>"),
        theme.button("u", icons.SignIn .. " Find session",
          "<cmd>Telescope possession list<cr><cmd>Project! root<cr>"),
        -- theme.button("y", icons.Reference .. " Restore current session", "<cmd>lua require('persistence').load()<cr>"),

        theme.button("s", icons.FindFile .. " Find file", "<cmd>Telescope find_files<CR>"),
        theme.button("r", icons.RecentlyUsed .. " Recently used files", "<cmd>Telescope oldfiles<CR>"),
        theme.button("p", icons.Folder .. " Find project", "<cmd>Telescope projects<cr><cmd>Project! root<cr>"),
        theme.button("l", icons.Text .. " Find text", "<cmd>Telescope live_grep<CR>"),
        theme.button("t", icons.Telescope .. " Open Telescope", "<cmd>Telescope<cr>"),

        -- theme.button("o", icons.Neorg .. " Neorg workspace",
        --   "<cmd>Telescope neorg switch_workspace<cr><cmd>Project! root<cr>"),
        -- theme.button("n", icons.Neorg .. " Neorg notes", "<cmd>Neorg workspace notes<cr><cmd>Project! root<cr>"),
        -- theme.button("m", icons.Neorg .. " Neorg tasks", "<cmd>Neorg workspace tasks<cr><cmd>Project! root<cr>"),

        theme.button("h", icons.Checkhealth .. " Checkhealth", "<cmd>checkhealth<cr>"),
        theme.button("q", icons.Quit .. " Quit nvim", "<cmd>qa<cr>"),
      },
      opts = {
        spacing = 1,
      }
    }

    local footer = {
      type = "text",
      val = {
        "https://git.klephron.xyz/klephron/dotfiles.git"
      },
      opts = {
        position = "center",
        hl = "Number",
      },
    }

    local config = {
      layout = {
        { type = "padding", val = 2 },
        header,
        { type = "padding", val = 2 },
        buttons,
        { type = "padding", val = 1 },
        footer
      },
      opts = {
        margin = 0,
      }
    }
    alpha.setup(config)
  end
}
