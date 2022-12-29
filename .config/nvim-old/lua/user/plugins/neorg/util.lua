local M = {}

function M.load_wrapper(callback)
  return function()
    if not require("neorg").is_loaded() then
      vim.cmd("NeorgStart")
      vim.notify('Loaded.', vim.log.levels.INFO, { title = 'Neorg' })
    end
    if type(callback) == 'function' then return callback()
    elseif type(callback) == 'string' then return vim.cmd(callback) end
  end
end

function M.cmd(str)
  return "<cmd>" .. str .. "<cr>"
end

return M
