local M = {}

function M.setup()
  local kmps = require("user.keymaps").dap
  local funcs = require("user.plugins.dap.funcs")

  us.set_keynomap("n", kmps.continue.key, funcs.continue, kmps.continue.desc)
  us.set_keynomap("n", kmps.run_last.key, funcs.run_last, kmps.run_last.desc)
  us.set_keynomap("n", kmps.process_launchjs.key, funcs.process_launchjs_ask, kmps.process_launchjs.desc)
  us.set_keynomap("n", kmps.terminate.key, funcs.terminate, kmps.terminate.desc)
  us.set_keynomap("n", kmps.disconnect.key, funcs.disconnect, kmps.disconnect.desc)
  us.set_keynomap("n", kmps.close.key, funcs.close, kmps.close.desc)
  us.set_keynomap("n", kmps.set_breakpoint_cond.key, funcs.set_breakpoint_cond, kmps.set_breakpoint_cond.desc)
  us.set_keynomap("n", kmps.set_breakpoint_log.key, funcs.set_breakpoint_log, kmps.set_breakpoint_log.desc)
  us.set_keynomap("n", kmps.toggle_breakpoint.key, funcs.toggle_breakpoint, kmps.toggle_breakpoint.desc)
  us.set_keynomap("n", kmps.clear_breakpoints.key, funcs.clear_breakpoints, kmps.clear_breakpoints.desc)
  us.set_keynomap("n", kmps.step_over.key, funcs.step_over, kmps.step_over.desc)
  us.set_keynomap("n", kmps.step_into.key, funcs.step_into, kmps.step_into.desc)
  us.set_keynomap("n", kmps.step_out.key, funcs.step_out, kmps.step_out.desc)
  us.set_keynomap("n", kmps.step_back.key, funcs.step_back, kmps.step_back.desc)
  -- us.set_keynomap("n", kmps.pause.key, dap.pause, kmps.pause.desc)
  us.set_keynomap("n", kmps.reverse_continue.key, funcs.reverse_continue, kmps.reverse_continue.desc)
  us.set_keynomap("n", kmps.up.key, funcs.up, kmps.up.desc)
  us.set_keynomap("n", kmps.down.key, funcs.down, kmps.down.desc)
  us.set_keynomap("n", kmps.run_to_cursor.key, funcs.run_to_cursor, kmps.run_to_cursor.desc)
  us.set_keynomap("n", kmps.repl_toggle.key, funcs.repl_toggle, kmps.repl_toggle.desc)
  -- us.set_keynomap("n", kmps.repl_session.key, dap.repl.session, kmps.repl_session.desc)
  us.set_keynomap("n", kmps.hover.key, funcs.hover, kmps.hover.desc)
  us.set_keynomap("n", kmps.dapui_toggle.key, funcs.dapui_toggle, kmps.dapui_toggle.desc)

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
