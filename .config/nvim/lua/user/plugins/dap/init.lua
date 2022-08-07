local M = {}

function M.setup()
  local kmps = require("user.keymaps").dap
  local funcs = require("user.plugins.dap.funcs")

  us.set_keynomap("n", kmps.continue, funcs.continue, "dap: Continue")
  us.set_keynomap("n", kmps.run_last, funcs.run_last, "dap: Run last")
  us.set_keynomap("n", kmps.launch, funcs.launch, "dap: Launch")
  us.set_keynomap("n", kmps.terminate, funcs.terminate, "dap: Terminate")
  us.set_keynomap("n", kmps.disconnect, funcs.disconnect, "dap: Disconnect")
  us.set_keynomap("n", kmps.close, funcs.close, "dap: Close")
  us.set_keynomap("n", kmps.set_breakpoint_cond, funcs.set_breakpoint_cond, "dap: Set conditional breakpoint")
  us.set_keynomap("n", kmps.set_breakpoint_log, funcs.set_breakpoint_log, "dap: Set log breakpoint")
  us.set_keynomap("n", kmps.toggle_breakpoint, funcs.toggle_breakpoint, "dap: Toggle breakpoint")
  us.set_keynomap("n", kmps.clear_breakpoints, funcs.clear_breakpoints, "dap: Clear breakpoints")
  us.set_keynomap("n", kmps.step_over, funcs.step_over, "dap: Step over")
  us.set_keynomap("n", kmps.step_into, funcs.step_into, "dap: Step into")
  us.set_keynomap("n", kmps.step_out, funcs.step_out, "dap: Step out")
  us.set_keynomap("n", kmps.step_back, funcs.step_back, "dap: Step back")
  -- us.set_keynomap("n", kmps.pause, dap.pause, "dap: Pause")
  us.set_keynomap("n", kmps.reverse_continue, funcs.reverse_continue, "dap: Reverse continue")
  us.set_keynomap("n", kmps.up, funcs.up, "dap: Up")
  us.set_keynomap("n", kmps.down, funcs.down, "dap: Down")
  us.set_keynomap("n", kmps.run_to_cursor, funcs.run_to_cursor, "dap: Run to cursor")
  us.set_keynomap("n", kmps.repl_toggle, funcs.repl_toggle, "dap: REPL toggle")
  -- us.set_keynomap("n", kmps.repl_session, dap.repl.session, "dap: REPL session")
  us.set_keynomap("n", kmps.hover, funcs.hover, "dap: Hover")
  us.set_keynomap("n", kmps.dapui_toggle, funcs.dapui_toggle, "dapui: Toggle")

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
