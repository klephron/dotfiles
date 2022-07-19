return function()
  local status_ok, alpha = safe_require("alpha")
  if not status_ok then
    return
  end

  -- imports
  local theme = require("alpha.themes.dashboard")
  local icons = require("user.icons").alpha

  -- header
  local header = {
    type = "text",
    val = theme.section.header.val,
    opts = {
      position = "center",
      hl = "Character"
    }
  }

  -- buttons
  local buttons = {
    type = "group",
    val = {
      theme.button("f", icons.FindFile .. " Find file", "<cmd>Telescope find_files <CR>"),
      theme.button("e", icons.File .. " New file", "<cmd>ene<BAR>startinsert<cr>"),
      theme.button("r", icons.RecentlyUsed .. " Recently used files", "<cmd>Telescope oldfiles <CR>"),
      theme.button("c", icons.Settings .. " Edit config", "<cmd>e $MYVIMRC<cr>"),
      theme.button("p", icons.Folder .. " Find project", "<cmd>Telescope projects <CR>"),
      theme.button("t", icons.Text .. " Find text", "<cmd>Telescope live_grep<CR>"),
      theme.button("l", icons.Telescope .. " Open Telescope", "<cmd>Telescope<cr>"),
      theme.button("q", icons.Quit .. " Quit nvim", "<cmd>qa<cr>"),
    },
    opts = {
      spacing = 1,
    }
  }

  -- footer
  local footer = {
    type = "text",
    val = {
      -- [[ぴちぴちー                         ]],
      -- [[ぴっ ぴちぴちー                    ]],
      -- [[にゃんぱすー                       ]],
      -- [[よくわからないけどドンマイなの     ]],
      -- [[ゴロゴロー おジュースいりませんか  ]],
      -- [[ピーマン汁 小松菜汁 ほうれん草汁   ]],
      -- [[ねーね 朝ご飯の時間なん            ]],
      -- [[うち台車役やりたい 新幹線ごっこー  ]],
      -- [[お やれやれ                        ]],
      -- [[ねーね できたー                    ]],
      -- [[問題集できた                       ]],
      -- [[あーい うちも食べる                ]],
      -- [[だんご虫だーい                     ]],
      -- [[よっ にゃんぱすー                  ]],
      -- [[あーい                             ]],
      "https://github.com/zubrailx"
    },
    opts = {
      position = "center",
      hl = "Number",
    },
  }


  -- config
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
