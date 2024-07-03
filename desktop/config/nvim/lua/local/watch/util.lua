local uv = vim.loop
local fn = vim.fn
local api = vim.api

local M = {}

---@param msg string
---@param level any
---@return nil
local function watch_notify(msg, level)
  return vim.notify(msg, level, { title = "Watch" })
end

---@param name string
local function create_file_if_not_exist(name)
  if not uv.fs_stat(name) then
    local ok, fd = pcall(uv.fs_open, name, "w", 420)
    if not ok then
      watch_notify("Couldn't open file " .. name, vim.log.levels.WARN)
      return
    end
    uv.fs_close(fd)
  end
end

---@param name string
---@param is_buflisted boolean
---@return number
local function open_buffer(name, is_buflisted)
  local bufnr = fn.bufnr(name)
  if bufnr == -1 then
    bufnr = api.nvim_create_buf(is_buflisted, true)
    api.nvim_buf_set_name(bufnr, name)
  end
  api.nvim_buf_set_option(bufnr, "buftype", "")
  api.nvim_buf_set_option(bufnr, "modifiable", true)
  return bufnr
end

---@param t1 table
---@param t2 table
local function tbl_equals(t1, t2)
  if t1 == t2 then return true end
  for k, v in pairs(t1) do
    if v ~= t2[k] then return false end
  end
  return true
end

---Trim string
---@param str string
local function trim(str)
  return str:gsub("^%s*(.-)%s*$", "%1")
end

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

M.watch_notify = watch_notify
M.create_file_if_not_exist = create_file_if_not_exist
M.open_buffer = open_buffer
M.tbl_equals = tbl_equals
M.trim = trim
M.augroup = augroup

return M
