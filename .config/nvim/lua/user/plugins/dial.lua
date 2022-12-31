local M = {
  "monaqa/dial.nvim",
}

function M.config()
  local dial = require("dial.map")
  local augend = require("dial.augend")
  local config = require("dial.config")

  us.set_keynomap("n", '<C-a>', dial.inc_normal())
  us.set_keynomap("n", '<C-x>', dial.dec_normal())
  us.set_keynomap("v", '<C-a>', dial.inc_visual())
  us.set_keynomap("v", '<C-x>', dial.dec_visual())
  us.set_keynomap("v", 'g<C-a>', dial.inc_gvisual())
  us.set_keynomap("v", 'g<C-x>', dial.dec_gvisual())

  config.augends:register_group({
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

return M
