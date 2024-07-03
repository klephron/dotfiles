local M = {}

local fmt = string.format
local fn = vim.fn
local api = vim.api

function M.safe_require(module, opts)
  opts = opts or { silent = false }
  local ok, result = pcall(require, module)
  if not ok and not opts.silent then
    vim.notify(result, vim.log.levels.ERROR, { title = fmt('Error requiring: %s', module) })
  end
  return ok, result
end

-- MAPPINGS
local function call_mapping(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function resolve_opts(opts)
  return type(opts) == 'string' and { desc = opts } or opts or {}
end

local remap_opts = { silent = true, remap = true }
local nomap_opts = { silent = true }

M.set_keyremap = function(mode, lhs, rhs, opts)
  opts = resolve_opts(opts)
  opts = vim.tbl_extend('keep', opts, remap_opts)
  call_mapping(mode, lhs, rhs, opts)
end

M.set_keynomap = function(mode, lhs, rhs, opts)
  opts = resolve_opts(opts)
  opts = vim.tbl_extend('keep', opts, nomap_opts)
  call_mapping(mode, lhs, rhs, opts)
end

M.try_unmap = function(mode, lhs, buflocal)
  if fn.maparg(lhs, mode) ~= '' then
    if buflocal then
      api.nvim_buf_del_keymap(api.nvim_get_current_buf(), mode, lhs)
    else
      api.nvim_del_keymap(mode, lhs)
    end
  end
end

---@class Autocommand
---@field description string|nil
---@field event  string|string[] list of autocommand events (use list if more than one)
---@field pattern string|string[]|nil list of autocommand patterns
---@field command string|function
---@field nested  boolean|nil
---@field once    boolean|nil
---@field buffer  number|nil

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param group string
---@param commands Autocommand[]
---@return number
M.augroup = function(group, commands)
  local id = api.nvim_create_augroup(group, { clear = true })
  for _, autocmd in ipairs(commands) do
    local is_callback = type(autocmd.command) == 'function'
    api.nvim_create_autocmd(autocmd.event, {
      group = group,
      pattern = autocmd.pattern,
      desc = autocmd.description,
      callback = is_callback and autocmd.command or nil,
      command = not is_callback and autocmd.command or nil,
      once = autocmd.once,
      nested = autocmd.nested,
      buffer = autocmd.buffer,
    })
  end
  return id
end

---Reload lua modules
---@param path string
---@param recursive boolean
M.reload = function(path, recursive)
  if recursive then
    for key, value in pairs(package.loaded) do
      if key ~= '_G' and value and fn.match(key, path) ~= -1 then
        -- table[key] = value
        package.loaded[key] = nil
        require(key)
      end
    end
  else
    package.loaded[path] = nil
    require(path)
  end
end

---Get color of highlight. Type of color should be table { hi, fg|bg } or HEX string
M.color = function(val)
  if type(val) == "string" then
    return val
  elseif type(val) == "table" then
    return fn.synIDattr(fn.synIDtrans(fn.hlID(val[1])), val[2] .. "#")
  else
    assert(false, "type of color should be table { hi, fg|bg } or HEX")
  end
end

return M
