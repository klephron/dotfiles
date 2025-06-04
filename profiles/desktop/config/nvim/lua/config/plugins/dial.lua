local M = {
  "monaqa/dial.nvim",
  config = function()
    local augend = require("dial.augend")
    local dial_config = require("dial.config")

    dial_config.augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.bool,
        augend.semver.alias.semver,
        augend.constant.new({
          elements = { '&&', '||' },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { 'and', 'or' },
          word = false,
          cyclic = true,
        }),
        augend.case.new({
          types = { 'camelCase', 'snake_case', 'PascalCase', 'SCREAMING_SNAKE_CASE' },
          cyclic = true,
        }),
      },
    })
  end,
  keys = {
    { "<C-a>", "<Plug>(dial-increment)", mode = "n", desc = "dial: Increment" },
    { "<C-x>", "<Plug>(dial-decrement)", mode = "n", desc = "dial: Decrement" },
    { "<C-a>", "<Plug>(dial-increment)", mode = "v", desc = "dial: Increment" },
    { "<C-x>", "<Plug>(dial-decrement)", mode = "v", desc = "dial: Decrement" },
  }
}

return M
