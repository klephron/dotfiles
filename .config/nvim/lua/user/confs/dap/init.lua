local M = {}

function M.setup()
  local kmps = require("user.keymaps").dap
  local kmps_fn = require("user.keymaps").dap_fn
  local funcs = require("user.confs.dap.funcs")

  us.set_keynomap("n", kmps.continue.key, funcs.continue, kmps:desc("continue"))
  us.set_keynomap("n", kmps.run_last.key, funcs.run_last, kmps:desc("run_last"))
  us.set_keynomap("n", kmps.process_launchjs.key, funcs.process_launchjs_ask, kmps:desc("process_launchjs"))
  us.set_keynomap("n", kmps.terminate.key, funcs.terminate, kmps:desc("terminate"))
  us.set_keynomap("n", kmps.disconnect.key, funcs.disconnect, kmps:desc("disconnect"))
  -- us.set_keynomap("n", kmps.close.key, funcs.close, kmps:desc("close"))
  us.set_keynomap("n", kmps.set_breakpoint_cond.key, funcs.set_breakpoint_cond, kmps:desc("set_breakpoint_cond"))
  us.set_keynomap("n", kmps.set_breakpoint_log.key, funcs.set_breakpoint_log, kmps:desc("set_breakpoint_log"))
  us.set_keynomap("n", kmps.toggle_breakpoint.key, funcs.toggle_breakpoint, kmps:desc("toggle_breakpoint"))
  us.set_keynomap("n", kmps.clear_breakpoints.key, funcs.clear_breakpoints, kmps:desc("clear_breakpoints"))
  us.set_keynomap("n", kmps.step_over.key, funcs.step_over, kmps:desc("step_over"))
  us.set_keynomap("n", kmps.step_into.key, funcs.step_into, kmps:desc("step_into"))
  us.set_keynomap("n", kmps.step_out.key, funcs.step_out, kmps:desc("step_out"))
  us.set_keynomap("n", kmps.step_back.key, funcs.step_back, kmps:desc("step_back"))
  -- us.set_keynomap("n", kmps.pause.key, dap.pause, kmps:desc("pause"))
  us.set_keynomap("n", kmps.reverse_continue.key, funcs.reverse_continue, kmps:desc("reverse_continue"))
  us.set_keynomap("n", kmps.up.key, funcs.up, kmps:desc("up"))
  us.set_keynomap("n", kmps.down.key, funcs.down, kmps:desc("down"))
  us.set_keynomap("n", kmps.run_to_cursor.key, funcs.run_to_cursor, kmps:desc("run_to_cursor"))
  us.set_keynomap("n", kmps.repl_toggle.key, funcs.repl_toggle, kmps:desc("repl_toggle"))
  -- us.set_keynomap("n", kmps.repl_session.key, dap.repl.session, kmps:desc("repl_session"))
  us.set_keynomap("n", kmps.hover.key, funcs.hover, kmps:desc("hover"))
  us.set_keynomap("n", kmps.dapui_toggle.key, funcs.dapui_toggle, kmps:desc("dapui_toggle"))

  -- Bind FN mappings for dap
  us.set_keynomap("n", kmps_fn.step_over.key, funcs.step_over, kmps_fn:desc("step_over"))
  us.set_keynomap("n", kmps_fn.step_into.key, funcs.step_into, kmps_fn:desc("step_into"))
  us.set_keynomap("n", kmps_fn.step_out.key, funcs.step_out, kmps_fn:desc("step_out"))
  us.set_keynomap("n", kmps_fn.step_back.key, funcs.step_back, kmps_fn:desc("step_back"))
  us.set_keynomap("n", kmps_fn.run_to_cursor.key, funcs.run_to_cursor, kmps_fn:desc("run_to_cursor"))

  us.set_keynomap("n", kmps_fn.continue.key, funcs.continue, kmps_fn:desc("continue"))
  us.set_keynomap("n", kmps_fn.run_last.key, funcs.run_last, kmps_fn:desc("run_last"))
  us.set_keynomap("n", kmps_fn.terminate.key, funcs.terminate, kmps_fn:desc("terminate"))

  us.set_keynomap("n", kmps_fn.toggle_breakpoint.key, funcs.toggle_breakpoint, kmps_fn:desc("toggle_breakpoint"))
  us.set_keynomap("n", kmps_fn.clear_breakpoints.key, funcs.clear_breakpoints, kmps_fn:desc("clear_breakpoints"))

  us.set_keynomap("n", kmps_fn.hover.key, funcs.hover, kmps_fn:desc("hover"))
  -- OTHER:
  -- E = { ":lua require('dap').list_breakpoints()<cr>", ":lua require('dap').list_breakpoints()<cr>" },
  -- q = { ":lua require('dap').set_exception_breakpoints()<cr>", ":lua require('dap').set_exception_breakpoints()<cr>" },
  -- V = { ":lua require('dap').goto_()<cr>", ":lua require('dap').goto_()<cr>" },
  -- E = { ":lua require('dap.ui.widgets').()<cr>", ":lua require('dap.ui.widgets').hover()<cr>" },
  -- scopes, frames, expression, threads

  local hydra_ok, hydra = safe_require("user.confs.hydra")
  if hydra_ok then
    hydra.hydras.dap()
  end
end

function M.config()

  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  -- vim.fn.sign_define('DapStopped', {text='→', texthl='DapStopped', linehl=nil, numhl=''})
  --
  require("user.confs.dap.langs")
  require('telescope').load_extension('dap')
end

return M
