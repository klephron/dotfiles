local uv = vim.loop
local api = vim.api
local fn = vim.fn

local function watch_notify(msg, level)
  return vim.notify(msg, level, { title = "Watch" })
end

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

local function open_buffer(name)
  local bufnr = fn.bufnr(name)
  if bufnr == -1 then
    bufnr = api.nvim_create_buf(true, true)
    api.nvim_buf_set_name(bufnr, name)
  end
  api.nvim_buf_set_option(bufnr, "buftype", "")
  api.nvim_buf_set_option(bufnr, "modifiable", true)
  return bufnr
end

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
    on_stdout = append_data,
    on_stderr = append_data,
    on_exit = function()
      api.nvim_buf_call(bufnr, function()
        vim.cmd("w!")
      end)
    end
  })
end

api.nvim_create_user_command("UsWatch", function()
  local command = fn.input("Command: ")
  local name = fn.input("Output file: ", fn.getcwd() .. "/", "file")
  us.augroup("us_watcher", {
    {
      event = "BufWritePost",
      pattern = fn.input("Pattern: "),
      command = function()
        write_command_output(command, name)
      end,
    },
  })
end, {})
