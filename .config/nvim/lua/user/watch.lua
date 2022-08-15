local uv = vim.loop
local api = vim.api
local fn = vim.fn

---@class WatchTable
---@field command string
---@field pattern string

---@type table<string, WatchTable>
local watch_files = {}

local config = {
  file = {
    remove = true,
    overwrite = true,
  },
  run_on_create = true,
  decorator = { -- example: treat stdout as terminal
    enabled = true,
    left = 'script -q -c "',
    right = '" /dev/null',
  },
  buflisted = false,
}

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
local function open_buffer(name)
  local bufnr = fn.bufnr(name)
  if bufnr == -1 then
    bufnr = api.nvim_create_buf(config.buflisted, true)
    api.nvim_buf_set_name(bufnr, name)
  end
  api.nvim_buf_set_option(bufnr, "buftype", "")
  api.nvim_buf_set_option(bufnr, "modifiable", true)
  return bufnr
end

---@param command string
---@param name string
local function write_command_output(command, name)
  create_file_if_not_exist(name)
  local bufnr = open_buffer(name)
  -- print command
  api.nvim_buf_set_lines(bufnr, 0, -1, false, { "filename: " .. name, command, "" })
  -- func
  local append_data = function(_, data, output)
    api.nvim_buf_set_lines(bufnr, -1, -1, false, { output .. ":" })
    if data then
      api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
    end
  end
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = append_data,
    on_stderr = append_data,
    on_exit = function()
      api.nvim_buf_call(bufnr, function()
        vim.cmd("w!")
      end)
    end
  })
end

---@param name string
local function get_augroup_name(name)
  return "us_watcher_" .. name
end

api.nvim_create_user_command("UsWatchCreate", function()
  local command = fn.input("Command: ")
  local name = fn.input("Output file: ", fn.getcwd() .. "/", "file")
  -- overwrite
  if not config.file.overwrite and uv.fs_stat(name) then
    local res = fn.input("File exists. Overwrite it? (y/n): "):sub(1, 1)
    if res == "n" or res == "N" then
      return
    end
  end
  local pattern = fn.input("Pattern: ")
  if command == "" or name == "" or pattern == "" then
    watch_notify("Aborted.", vim.log.levels.INFO)
    return
  end
  -- decorator
  if config.decorator.enabled then
    command = config.decorator.left .. command .. config.decorator.right
  end
  -- run-on-create
  if config.run_on_create then
    write_command_output(command, name)
  end
  local augroup = get_augroup_name(name)
  us.augroup(augroup, {
    {
      event = "BufWritePost",
      pattern = pattern,
      command = function()
        write_command_output(command, name)
      end,
    },
  })
  if vim.tbl_contains(vim.tbl_keys(watch_files), name) then
    watch_notify("Watch " .. name .. " is overridden.", vim.log.levels.WARN)
  else
    watch_files[name] = { command = command, pattern = pattern }
  end
end, {})

api.nvim_create_user_command("UsWatchList", function()
  print(vim.inspect(watch_files))
end, {})

api.nvim_create_user_command("UsWatchDelete", function()
  vim.ui.select(vim.tbl_keys(watch_files), {
    prompt = "Select file:",
  },
    function(choice)
      if choice == nil then return end
      local name = choice
      local augroup = get_augroup_name(name)
      if vim.tbl_contains(vim.tbl_keys(watch_files), name) then
        api.nvim_del_augroup_by_name(augroup)
        watch_files[name] = nil
        -- file-remove
        if config.file.remove and uv.fs_stat(name) then
          local bufnr = fn.bufnr(name)
          if bufnr ~= -1 then api.nvim_buf_delete(bufnr, {}) end
          uv.fs_unlink(name)
        end
      end
    end)
end, { nargs = 0 })

us.augroup("us_watch_leave", {
  {
    event = "VimLeavePre",
    pattern = "*",
    command = function()
      if config.file.remove then
        for name, _ in pairs(watch_files) do
          if uv.fs_stat(name) then
            uv.fs_unlink(name)
          end
        end
      end
    end
  }
})
