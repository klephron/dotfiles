local fmt = string.format


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

function us.dump_lua_table(table)
  return vim.inspect(table)
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
  if idx == 0 then return end
  if idx == size then
    vim.cmd("bprevious")
  else
    vim.cmd("bnext")
  end
  vim.cmd("bdelete " .. cbn)
end

function us.table_contains(table, value)
  for _, e in ipairs(table) do
    if value == e then return true end
  end
  return false
end

-- MAPPINGS
local function call_mapping(mode, lhs, rhs, opts)
  if type(mode) == "string" then
    for i = 1, #mode do
      vim.keymap.set(mode:sub(i, i), lhs, rhs, opts)
    end
  elseif type(mode) == "table" then
    vim.keymap.set(mode, lhs, rhs, opts)
  else
    vim.notify(vim.inspect(mode), vim.log.levels.ERROR, { title = 'Error setting keymap' })
  end
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
