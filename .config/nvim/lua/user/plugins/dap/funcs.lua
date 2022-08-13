local dap = require("dap")
local widgets = require("dap.ui.widgets")
local dapui = require("dapui")

local M = {}
M.func = {}

local function dap_notify(msg, level)
  vim.notify(msg, level, { title = "Dap" })
end

function M.continue()
  return dap.continue()
end

function M.run_last()
  return dap.run_last()
end

local launchjs_paths = {
  '/launch.json',
  '/.vscode/launch.json',
}

function M.process_launchjs()
  local path = nil
  for _, ipath in ipairs(launchjs_paths) do
    local resolved_path = vim.fn.getcwd() .. ipath
    if vim.loop.fs_stat(resolved_path) then
      path = resolved_path
      break
    end
  end
  if path == nil then
    path = vim.fn.input('Path to launch.json: ', vim.fn.getcwd() .. '/', 'file')
    if not vim.loop.fs_stat(path) then
      dap_notify("Not resolved path: " .. path .. "\nReturning...", vim.log.levels.WARN)
      return
    end
  end
  dap_notify("Resolved launch.json path: " .. path, vim.log.levels.INFO)

  local ttft = require('user.plugins.dap.langs').type_to_filetype
  return require("dap.ext.vscode").load_launchjs(path, ttft)
end

function M.terminate()
  return dap.terminate()
end

function M.disconnect()
  return dap.disconnect()
end

function M.close()
  return dap.close()
end

function M.set_breakpoint_cond()
  return dap.set_breakpoint(vim.fn.input("[Condition]: "))
end

function M.set_breakpoint_log()
  return dap.set_breakpoint(nil, nil, vim.fn.input('[Log message]: '))
end

function M.toggle_breakpoint()
  return dap.toggle_breakpoint()
end

function M.clear_breakpoints()
  return dap.clear_breakpoints()
end

function M.step_over()
  return dap.step_over()
end

function M.step_into()
  return dap.step_into()
end

function M.step_out()
  return dap.step_out()
end

function M.step_back()
  return dap.step_back()
end

function M.reverse_continue()
  return dap.reverse_continue()
end

function M.up()
  return dap.up()
end

function M.down()
  return dap.down()
end

function M.run_to_cursor()
  return dap.run_to_cursor()
end

function M.repl_toggle()
  return dap.repl.toggle()
end

function M.hover()
  return widgets.hover()
end

function M.dapui_toggle()
  return dapui.toggle()
end

return M
