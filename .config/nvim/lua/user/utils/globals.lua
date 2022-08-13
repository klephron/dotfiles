local fmt = string.format
local api = vim.api
local fn = vim.fn


_G.us = {
  prefix = {
    plugins = "user.plugins"
  }
}


function _G.safe_require(module, opts)
  opts = opts or { silent = false }
  local ok, result = pcall(require, module)
  if not ok and not opts.silent then
    vim.notify(result, vim.log.levels.ERROR, { title = fmt('Error requiring: %s', module) })
  end
  return ok, result
end

function us.delete_current_buffer()
  local cbn = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({ buflisted = true })
  local size = 0
  local idx = 0
  for n, e in ipairs(buffers) do
    size = size + 1
    if e.bufnr == cbn then
      idx = n
    end
  end
  if idx ~= 0 then
    if idx == size then
      vim.cmd("bprevious")
    else
      vim.cmd("bnext")
    end
  end
  vim.cmd("bdelete! " .. cbn) -- wall! is enabled on delete is enabled
end

function us.table_contains(table, value)
  for _, e in ipairs(table) do
    if value == e then return true end
  end
  return false
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

us.set_keyremap = function(mode, lhs, rhs, opts)
  opts = resolve_opts(opts)
  opts = vim.tbl_extend('keep', opts, remap_opts)
  call_mapping(mode, lhs, rhs, opts)
end

us.set_keynomap = function(mode, lhs, rhs, opts)
  opts = resolve_opts(opts)
  opts = vim.tbl_extend('keep', opts, nomap_opts)
  call_mapping(mode, lhs, rhs, opts)
end

---@class Autocommand
---@field description string
---@field event  string[] list of autocommand events
---@field pattern string[] list of autocommand patterns
---@field command string | function
---@field nested  boolean
---@field once    boolean
---@field buffer  number

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param group string
---@param commands Autocommand[]
---@return number
function us.augroup(group, commands)
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
---@param recursive string
function us.reload(path, recursive)
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
