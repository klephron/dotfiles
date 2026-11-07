local fmt = string.format
local fn = vim.fn
local api = vim.api

local function require_safe(module, opts)
  opts = opts or { silent = false }
  local ok, result = pcall(require, module)
  if not ok and not opts.silent then
    vim.notify(result, vim.log.levels.ERROR, { title = fmt('Error requiring: %s', module) })
  end
  return ok, result
end

local function map_call(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function map_opts_resolve(opts)
  return type(opts) == 'string' and { desc = opts } or opts or {}
end

local map_opts_re = { silent = true, remap = true }
local map_opts_no = { silent = true }

local function map_set_keyremap(mode, lhs, rhs, opts)
  opts = map_opts_resolve(opts)
  opts = vim.tbl_extend('keep', opts, map_opts_re)
  map_call(mode, lhs, rhs, opts)
end

local function map_set_keynomap(mode, lhs, rhs, opts)
  opts = map_opts_resolve(opts)
  opts = vim.tbl_extend('keep', opts, map_opts_no)
  map_call(mode, lhs, rhs, opts)
end

local function map_try_unmap(mode, lhs, buflocal)
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
local function augroup(group, commands)
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
local function reload(path, recursive)
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
local function color(val)
  if type(val) == "string" then
    return val
  elseif type(val) == "table" then
    return fn.synIDattr(fn.synIDtrans(fn.hlID(val[1])), val[2] .. "#")
  else
    assert(false, "type of color should be table { hi, fg|bg } or HEX")
  end
end

return {
  require_safe = require_safe,
  set_keyremap = map_set_keyremap,
  set_keynomap = map_set_keynomap,
  try_unmap = map_try_unmap,
  augroup = augroup,
  reload = reload,
  color = color,
}
