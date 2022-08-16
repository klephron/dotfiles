local uv = vim.loop
local api = vim.api
local fn = vim.fn

---@class WatchTable
---@field command string[]
---@field pattern string

---@type table<string, WatchTable>
local watch_data = {}

local config = {
  file = {
    remove = true,
    overwrite = true,
  },
  run_on_create = true,
  decorator = { -- example: treat stdout as terminal
    enabled = true,
    left = 'script -qe -c "',
    right = '" /dev/null',
  },
  buflisted = false,
  register = {
    save_watch_path = true,
    reg = "+",
  },
  command = {
    stdout_buffered = true,
    stderr_buffered = true,
    split_pattern = {
      -- NOTE: it's just split so shell behaviur won't work
      "&&", ";"
    },
    exit_on_error = true,
    save_after_each = true,
    trim = true,
  }
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

---@param t1 table
---@param t2 table
local function tbl_equals(t1, t2)
  if t1 == t2 then return true end
  for k, v in pairs(t1) do
    if v ~= t2[k] then return false end
  end
  return true
end

---@param name string
local function write_command_output(name)
  create_file_if_not_exist(name)
  local bufnr = open_buffer(name)
  -- func
  local function append_data(_, data, output)
    if data and not tbl_equals(data, { "" }) then
      api.nvim_buf_set_lines(bufnr, -1, -1, false, { output .. ":" })
      api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
    end
  end
  -- print command name in file
  api.nvim_buf_set_lines(bufnr, 0, -1, false, { "filename: " .. name, "" })
  -- run jobs
  for _, cmd in ipairs(watch_data[name].command) do
    api.nvim_buf_set_lines(bufnr, -1, -1, false, { "command: " .. cmd })
    local exit_code = nil;
    local job_id = vim.fn.jobstart(cmd, {
      stdout_buffered = config.command.stdout_buffered,
      stderr_buffered = config.command.stderr_buffered,
      on_stdout = append_data,
      on_stderr = append_data,
      on_exit = function(_, exit, _)
        exit_code = exit;
        if config.command.save_after_each then
          api.nvim_buf_call(bufnr, function() vim.cmd("silent w!") end)
        end
      end
    })
    fn.jobwait({ job_id })
    if config.command.exit_on_error and job_id <= 0 or exit_code ~= 0 then break end
  end
  if not config.command.save_after_each then
    api.nvim_buf_call(bufnr, function() vim.cmd("silent w!") end)
  end
end

---@param name string
local function get_augroup_name(name)
  return "_watcher_" .. name
end

---@param name string
---@param command string
---@param pattern string
local function create_record(name, command, pattern)
  -- save and override
  if vim.tbl_contains(vim.tbl_keys(watch_data), name) then
    watch_notify("Watcher " .. name .. " is overridden.", vim.log.levels.WARN)
  end
  -- split commands
  local command_list = { command }
  for _, p in pairs(config.command.split_pattern) do
    for i, c in ipairs(command_list) do
      command_list[i] = vim.split(c, p, { trimempty = true })
    end
    command_list = vim.tbl_flatten(command_list)
  end
  -- trim commands
  if config.command.trim then
    for i, c in pairs(command_list) do
      command_list[i] = c:gsub("^%s*(.-)%s*$", "%1")
    end
  end
  -- decorator
  if config.decorator.enabled then
    for i, c in pairs(command_list) do
      command_list[i] = config.decorator.left .. c .. config.decorator.right
    end
  end
  -- store
  watch_data[name] = { command = command_list, pattern = pattern }
end

-- USER COMMANDS
api.nvim_create_user_command("WatchCreate", function()
  local command = fn.input("Command: ")
  local name = fn.input("Output file: ", fn.getcwd() .. "/", "file")
  -- ask to overwrite file
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
  create_record(name, command, pattern)
  -- run-on-create
  if config.run_on_create then
    write_command_output(name)
  end
  -- create augroup
  local augroup = get_augroup_name(name)
  us.augroup(augroup, {
    {
      event = "BufWritePost",
      pattern = pattern,
      command = function()
        write_command_output(name)
      end,
    },
  })
  -- save watch filename in register
  if config.register.save_watch_path then
    vim.cmd(":echon ''") -- clear commandline
    local reg_cmd = "" ..
        ":redir @" .. config.register.reg .. "\n" ..
        ":echon '" .. name .. "'\n" ..
        ":redir end"
    vim.cmd(reg_cmd)
  end
end, {})

api.nvim_create_user_command("WatchList", function()
  print(vim.inspect(watch_data))
end, {})

api.nvim_create_user_command("WatchDelete", function()
  vim.ui.select(vim.tbl_keys(watch_data), {
    prompt = "Select file:",
  },
    function(choice)
      if choice == nil then return end
      local name = choice
      local augroup = get_augroup_name(name)
      if vim.tbl_contains(vim.tbl_keys(watch_data), name) then
        api.nvim_del_augroup_by_name(augroup)
        watch_data[name] = nil
        -- file-remove
        if config.file.remove and uv.fs_stat(name) then
          local bufnr = fn.bufnr(name)
          if bufnr ~= -1 then api.nvim_buf_delete(bufnr, {}) end
          uv.fs_unlink(name)
        end
      end
    end)
end, { nargs = 0 })

us.augroup("_watch_leave", {
  {
    event = "VimLeavePre",
    pattern = "*",
    command = function()
      if config.file.remove then
        for name, _ in pairs(watch_data) do
          if uv.fs_stat(name) then
            uv.fs_unlink(name)
          end
        end
      end
    end
  }
})
