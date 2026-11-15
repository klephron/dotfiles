local utils = require("utils")

local all = {
  basic = "BASIC",
  default = "DEFAULT",
  firenvim = "FIRENVIM",
  neovide = "NEOVIDE",
  scrollback = "SCROLLBACK",
  vscode = "VSCODE",
}

local names = {}

for _, value in pairs(all) do
  table.insert(names, value)
end

local function exists(profile)
  return utils.contains(names, profile)
end

local function load(profile)
  if profile == all.basic then
    return require("profiles.basic")
  elseif profile == all.default then
    return require("profiles.default")
  elseif profile == all.firenvim then
    return require("profiles.firenvim")
  elseif profile == all.neovide then
    return require("profiles.neovide")
  elseif profile == all.scrollback then
    return require("profiles.scrollback")
  elseif profile == all.vscode then
    return require("profiles.vscode")
  end

  error(string.format(
    'Invalid profile: %s, Expected oneof: %s',
    profile,
    vim.json.encode(names)
  ), 2)

  return nil
end

return {
  all = all,
  exists = exists,
  load = load,
}
