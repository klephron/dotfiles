local fmt = string.format


local M = {}


function M.conf(name)
  return require(fmt("user.plugins.%s", name))
end


return M
