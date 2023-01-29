local uv = vim.loop
local api = vim.api
local fn = vim.fn

local util = require("watch.util")
local watch_notify = util.watch_notify
local create_file_if_not_exist = util.create_file_if_not_exist
local open_buffer = util.open_buffer
local tbl_equals = util.tbl_equals
local trim = util.trim

---@class WatchTable
---@field command_splitted string[]
---@field command string
---@field pattern string
--
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
  is_buflisted = false,
  register = {
    save_watch_path = true,
    reg = "+",
  },
  command = {
    stdout_buffered = true,
    stderr_buffered = true,
    split = {
      enabled = true,
      -- NOTE: it's just used to split so shell behaviur won't work
      pattern = { "&&", ";" },
    },
    exit_on_error = true,
    save_after_each = true,
    trim = true,
  }
}

---@param name string
local function get_augroup_name(name)
  return "_watcher_" .. name
end

---Apply decorator
---@param str string
---@return string
local function apply_decorator(str)
  return config.decorator.left .. str .. config.decorator.right
end

---Append data to file from stdin/stderr
---@param data table
---@param stream string
---@param bufnr number
local function append_data(bufnr, _, data, stream)
  if data and not tbl_equals(data, { "" }) then
    api.nvim_buf_set_lines(bufnr, -1, -1, false,
      { "[" .. string.upper(stream) .. "]" })
    api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
  end
end

---Execute multiple commands at once, more customizable, more options, prefered.
---@param name string
local function execute_multiple(name)
  create_file_if_not_exist(name)
  local bufnr = open_buffer(name, config.is_buflisted)
  local commands = watch_data[name].command_splitted
  local co = coroutine.create(function()
    for _, v in ipairs(commands) do
      coroutine.yield(v)
    end
  end)
  -- fn
  local function with_buffer(chan_id, data, stream)
    append_data(bufnr, chan_id, data, stream)
  end

  local function recursive()
    local ok, command = coroutine.resume(co)
    if not ok or command == nil then return end
    local job_id = nil
    api.nvim_buf_set_lines(bufnr, -2, -1, false, { "[COMMAND] " .. command })
    job_id = fn.jobstart(command, {
      stdout_buffered = config.command.stdout_buffered,
      stderr_buffered = config.command.stderr_buffered,
      on_stdout = with_buffer,
      on_stderr = with_buffer,
      on_exit = function(_, exit, _)
        if config.command.save_after_each then
          api.nvim_buf_call(bufnr, function() vim.cmd("silent w!") end)
        end
        if config.command.exit_on_error and job_id <= 0 or exit ~= 0 then return
        else recursive() end
      end
    })
  end

  -- api.nvim_buf_set_lines(bufnr, 0, -1, false, { "[FNAME] " .. name, "", "" })
  api.nvim_buf_set_lines(bufnr, 0, -1, false, { "" })
  recursive()
  if not config.command.save_after_each then
    api.nvim_buf_call(bufnr, function() vim.cmd("silent w!") end)
  end
end

---Execute command and write to stdout when all jobs will finish.
---@param name string
local function execute_single(name)
  create_file_if_not_exist(name)
  local bufnr = open_buffer(name, config.is_buflisted)
  local command = watch_data[name].command
  -- fn
  local function with_buffer(chan_id, data, stream)
    append_data(bufnr, chan_id, data, stream)
  end

  -- execute cmd and print output to the file, after that write file
  api.nvim_buf_set_lines(bufnr, 0, -1, false, { "[FNAME] " .. name, "" })
  api.nvim_buf_set_lines(bufnr, -1, -1, false, { "[COMMAND] " .. command })
  fn.jobstart(command, {
    stdout_buffered = config.command.stdout_buffered,
    stderr_buffered = config.command.stderr_buffered,
    on_stdout = with_buffer,
    on_stderr = with_buffer,
    on_exit = function()
      api.nvim_buf_call(bufnr, function() vim.cmd("silent w!") end)
    end
  })
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
  for _, p in pairs(config.command.split.pattern) do
    for i, c in ipairs(command_list) do
      command_list[i] = vim.split(c, p, { trimempty = true })
    end
    command_list = vim.tbl_flatten(command_list)
  end
  -- trim commands
  if config.command.trim then
    command = trim(command)
    for i, c in pairs(command_list) do
      command_list[i] = trim(c)
    end
  end
  -- decorator
  if config.decorator.enabled then
    for i, c in pairs(command_list) do
      command_list[i] = apply_decorator(c)
    end
    command = apply_decorator(command)
  end
  -- store
  watch_data[name] = { command_splitted = command_list, command = command, pattern = pattern }
end

local function execute(name)
  if config.command.split.enabled then
    execute_multiple(name)
  else
    execute_single(name)
  end
end

-- USER COMMANDS
api.nvim_create_user_command("WatchCreate", function()
  local command = fn.input("Command: ", "", "shellcmd")
  if command == "" then
    watch_notify("Aborted.", vim.log.levels.INFO)
    return
  end
  local name = fn.input("Output file: ", fn.getcwd() .. "/", "file")
  if name == "" then
    watch_notify("Aborted.", vim.log.levels.INFO)
    return
  end
  if not config.file.overwrite and uv.fs_stat(name) then
    local res = fn.input("File exists. Overwrite it? (y/n): "):sub(1, 1)
    if res == "n" or res == "N" then
      return
    end
  end
  local pattern = fn.input("Pattern: ")
  if pattern == "" then
    watch_notify("Aborted.", vim.log.levels.INFO)
    return
  end
  create_record(name, command, pattern)
  -- run-on-create
  if config.run_on_create then execute(name) end
  -- create augroup
  local augroup = get_augroup_name(name)
  us.augroup(augroup, {
    {
      event = "BufWritePost",
      pattern = pattern,
      command = function() execute(name) end,
    },
  })
  -- save watch filename in register
  if config.register.save_watch_path then
    local reg_cmd = "" ..
      ":redir @" .. config.register.reg .. "\n" ..
      ":echon '" .. name .. "'\n" ..
      ":redir end"
    vim.cmd(":echo '' | redraw") -- clear commandline
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
