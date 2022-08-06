local M = {}

function M.setup()
  local kmps = require("user.keymaps").dap
  local dap = require("dap")
  local widgets = require("dap.ui.widgets")

  local function set_breakpoint_cond()
    return dap.set_breakpoint(vim.fn.input("[Condition]: "))
  end

  local function set_breakpoint_log()
    return dap.set_breakpoint(nil, nil, vim.fn.input('[Log message]: '))
  end

  us.set_keynomap("n", kmps.continue, dap.continue, "dap: Continue")
  us.set_keynomap("n", kmps.run_last, dap.run_last, "dap: Run last")
  us.set_keynomap("n", kmps.launch, dap.launch, "dap: Launch")
  us.set_keynomap("n", kmps.terminate, dap.terminate, "dap: Terminate")
  us.set_keynomap("n", kmps.disconnect, dap.disconnect, "dap: Disconnect")
  us.set_keynomap("n", kmps.close, dap.close, "dap: Close")
  us.set_keynomap("n", kmps.set_breakpoint_cond, set_breakpoint_cond, "dap: Set conditional breakpoint")
  us.set_keynomap("n", kmps.set_breakpoint_log, set_breakpoint_log, "dap: Set log breakpoint")
  us.set_keynomap("n", kmps.toggle_breakpoint, dap.toggle_breakpoint, "dap: Toggle breakpoint")
  us.set_keynomap("n", kmps.clear_breakpoints, dap.clear_breakpoints, "dap: Clear breakpoints")
  us.set_keynomap("n", kmps.step_over, dap.step_over, "dap: Step over")
  us.set_keynomap("n", kmps.step_into, dap.step_into, "dap: Step into")
  us.set_keynomap("n", kmps.step_out, dap.step_out, "dap: Step out")
  us.set_keynomap("n", kmps.step_back, dap.step_back, "dap: Step back")
  -- us.set_keynomap("n", kmps.pause, dap.pause, "dap: Pause")
  us.set_keynomap("n", kmps.reverse_continue, dap.reverse_continue, "dap: Reverse continue")
  us.set_keynomap("n", kmps.up, dap.up, "dap: Up")
  us.set_keynomap("n", kmps.down, dap.down, "dap: Down")
  us.set_keynomap("n", kmps.run_to_cursor, dap.run_to_cursor, "dap: Run to cursor")
  us.set_keynomap("n", kmps.repl_toggle, dap.repl.toggle, "dap: REPL toggle")
  -- us.set_keynomap("n", kmps.repl_session, dap.repl.session, "dap: REPL session")
  us.set_keynomap("n", kmps.hover, widgets.hover, "dap: Hover")

  -- Dapui
  local dapui_ok, dapui = safe_require("dapui")
  if dapui_ok then
    us.set_keynomap("n", kmps.dapui_toggle, dapui.toggle, "dapui: Toggle")
  end
  -- OTHER:
  -- E = { ":lua require('dap').list_breakpoints()<cr>", ":lua require('dap').list_breakpoints()<cr>" },
  -- q = { ":lua require('dap').set_exception_breakpoints()<cr>", ":lua require('dap').set_exception_breakpoints()<cr>" },
  -- V = { ":lua require('dap').goto_()<cr>", ":lua require('dap').goto_()<cr>" },
  -- E = { ":lua require('dap.ui.widgets').()<cr>", ":lua require('dap.ui.widgets').hover()<cr>" },
  -- scopes, frames, expression, threads

  local hydra_ok, hydra = safe_require("user.plugins.hydra")
  if hydra_ok then
    hydra.hydras.dap()
  end
end

function M.config()

  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  -- vim.fn.sign_define('DapStopped', {text='→', texthl='DapStopped', linehl=nil, numhl=''})
  --
  require("user.plugins.dap.langs")
  require('telescope').load_extension('dap')
end

return M
