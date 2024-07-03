local M = {
  "monaqa/dial.nvim",
  event = "VeryLazy",
  config = function()
    local utils = u_require("funcs")
    local dial = require("dial.map")
    local augend = require("dial.augend")
    local dial_config = require("dial.config")

    utils.set_keynomap("n", '<C-a>', dial.inc_normal())
    utils.set_keynomap("n", '<C-x>', dial.dec_normal())
    utils.set_keynomap("v", '<C-a>', dial.inc_visual())
    utils.set_keynomap("v", '<C-x>', dial.dec_visual())
    utils.set_keynomap("v", 'g<C-a>', dial.inc_gvisual())
    utils.set_keynomap("v", 'g<C-x>', dial.dec_gvisual())

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
  end
}

return M
