local M = {}

local KeymapDictionary = require("user.utils.kmps_dict").KeymapDictionary

M.dap_fn = KeymapDictionary:new({
  step_into = { "<F1>", "Step into" },
  step_over = { "<F2>", "Step over" },
  step_out = { "<F3>", "Step out" },
  run_to_cursor = { "<F4>", "Run to cursor", },
  step_back = { "<F5>", "Step back" },

  hover = { "<F6>", "Hover" },

  run_last = { "<F7>", "Run last" },
  continue = { "<F8>", "Continue" },

  toggle_breakpoint = { "<F9>", "Toggle breakpoint" },
  clear_breakpoints = { "<F33>", "Clear breakpoints" }, -- Ctrl + <F9>

  terminate = { "<F10>", "Terminate" },
}, "dap-fn")

M.dap = KeymapDictionary:new({
  -- Main
  step_over = { "<leader>dn", "Step over" },
  step_into = { "<leader>di", "Step into" },
  step_out = { "<leader>do", "Step out" },
  step_back = { "<leader>dd", "Step back" },
  run_to_cursor = { "<leader>da", "Run to cursor" },

  up = { "<leader>d[", "Up" },
  down = { "<leader>d]", "Down" },

  continue = { "<leader>dc", "Continue" },
  run_last = { "<leader>dp", "Run last" },
  terminate = { "<leader>dt", "Terminate debug session" },

  set_breakpoint_cond = { "<leader>de", "Set conditional break" },
  set_breakpoint_log = { "<leader>dm", "Set log break" },
  toggle_breakpoint = { "<leader>ds", "Toggle breakpoint" },
  clear_breakpoints = { "<leader>dz", "Clear breakpoints" },

  hover = { "<leader>dh", "Hover" }, -- show variable
  dapui_toggle = { "<leader>dy", "Toggle dapui" },

  -- Optional
  process_launchjs = { "<leader>dl", "Process launchjs" },
  disconnect = { "<leader>db", "Disconnect from debuggee and terminate adapter" },
  -- close = { "<leader>dq", "Close" },
  -- pause = {"<leader>dp", "Pause"},
  reverse_continue = { "<leader>dr", "Reverse continue" },
  repl_toggle = { "<leader>dg", "Toggle REPL" },
  -- repl_session = { "<leader>dx", "REPL session" },
}, "dap")


function M.setup()
  local kmps = M.dap
  local fn_kmps = M.dap_fn
  local funcs = conf_require("config.dap.funcs")

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
  us.set_keynomap("n", fn_kmps.step_over.key, funcs.step_over, fn_kmps:desc("step_over"))
  us.set_keynomap("n", fn_kmps.step_into.key, funcs.step_into, fn_kmps:desc("step_into"))
  us.set_keynomap("n", fn_kmps.step_out.key, funcs.step_out, fn_kmps:desc("step_out"))
  us.set_keynomap("n", fn_kmps.step_back.key, funcs.step_back, fn_kmps:desc("step_back"))
  us.set_keynomap("n", fn_kmps.run_to_cursor.key, funcs.run_to_cursor, fn_kmps:desc("run_to_cursor"))

  us.set_keynomap("n", fn_kmps.continue.key, funcs.continue, fn_kmps:desc("continue"))
  us.set_keynomap("n", fn_kmps.run_last.key, funcs.run_last, fn_kmps:desc("run_last"))
  us.set_keynomap("n", fn_kmps.terminate.key, funcs.terminate, fn_kmps:desc("terminate"))

  us.set_keynomap("n", fn_kmps.toggle_breakpoint.key, funcs.toggle_breakpoint, fn_kmps:desc("toggle_breakpoint"))
  us.set_keynomap("n", fn_kmps.clear_breakpoints.key, funcs.clear_breakpoints, fn_kmps:desc("clear_breakpoints"))

  us.set_keynomap("n", fn_kmps.hover.key, funcs.hover, fn_kmps:desc("hover"))
end

return M
