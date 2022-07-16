local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

-- imports
local theme = require("alpha.themes.dashboard")
local icons = require("user.icons")

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
    theme.button("e", icons.NewFile .. " New file", "<cmd>ene<cr>"),
    theme.button("c", icons.Settings .. " Edit config", "<cmd>e $MYVIMRC<cr>"),
    theme.button("q", icons.Close .. " Quit nvim", "<cmd>qa<cr>"),
    theme.button("t", icons.Folder .. " Open nvim-tree in the current directory", "<cmd>ene<cr><cmd>NvimTreeOpen<cr>"),
    theme.button("s", icons.Telescope .. " Search files using Telescope", "<cmd>Telescope find_files<cr>"),
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
