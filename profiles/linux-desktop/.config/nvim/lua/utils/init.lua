local kmps_dict = require("utils.kmps_dict")
local nvim = require("utils.nvim")
local std = require("utils.std")

return {
  kmps_dict = kmps_dict,

  augroup = nvim.augroup,
  color = nvim.color,
  reload = nvim.reload,
  require_safe = nvim.require_safe,
  set_keynomap = nvim.set_keynomap,
  set_keyremap = nvim.set_keyremap,
  try_unmap = nvim.try_unmap,

  contains = std.contains,
  unpack = std.unpack,
}
