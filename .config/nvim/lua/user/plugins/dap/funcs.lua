local dap = require("dap")
local widgets = require("dap.ui.widgets")
local dapui = require("dapui")

local M = {}
M.func = {}

function M.continue()
  return dap.continue()
end

function M.run_last()
  return dap.run_last()
end

function M.launch()
  return dap.launch()
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
