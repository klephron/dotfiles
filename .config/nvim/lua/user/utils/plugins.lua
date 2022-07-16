local fmt = string.format


local M = {}


function M.conf(name)
  return require(fmt("%s.%s", us.prefix.plugins, name))
end

return M
