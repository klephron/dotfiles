local M = {}

local hydra = require("hydra")

local function key(kmp)
  return function() return kmp end
end

local dap_hint = [[
                                           ^^^^^^^^^^^^^^^^^^^^^^^DAP HYDRA:
 ^^^_%{runl}_: run last       ^_%{down}_: down                               ^^^^^^^^_%{togb}_: toggle break       _%{stin}_: step into 
 ^^^_%{lnch}_: launch         ^^^_%{up}_: up                ^_%{hov}_: hover         ^_%{sbc}_: conditional break  _%{stou}_: step out  
 ^^^_%{term}_: terminate   ^^^^_%{cont}_: continue          _%{rplt}_: toggle REPL   ^_%{sbl}_: log break          _%{stov}_: step over 
 ^^^_%{disc}_: disconnect      _%{revc}_: reverse continue  _%{duit}_: toggle dapui  _%{clrb}_: clear breaks       _%{stba}_: step back 
     _%{cls}_: close           _%{rutc}_: run to cursor                                            ^^^^^^^^^^^^^^^^^^^^^^_q_: exit 
]]

M.hydras = {
  dap = function()
    local kmps = require("user.keymaps").dap.hydra
    local fns = require("user.plugins.dap.funcs")
    hydra({
      name = "Dap hydra",
      mode = "n",
      body = kmps.body,
      hint = dap_hint,
      config = {
        exit = false,
        foreign_keys = "run",
        buffer = false,
        invoke_on_body = true,
        on_enter = function()

        end,
        on_exit = function()

        end,
        timeout = false,
        hint = {
          type = "window",
          position = "bottom",
          offset = 0,
          border = "rounded",
          show_name = true,
          funcs = {
            ["cont"] = key(kmps.continue),
            ["runl"] = key(kmps.run_last),
            ["lnch"] = key(kmps.launch),
            ["term"] = key(kmps.terminate),
            ["disc"] = key(kmps.disconnect),
            ["cls"] = key(kmps.close),
            ["sbc"] = key(kmps.set_breakpoint_cond),
            ["sbl"] = key(kmps.set_breakpoint_log),
            ["togb"] = key(kmps.toggle_breakpoint),
            ["clrb"] = key(kmps.clear_breakpoints),
            ["stov"] = key(kmps.step_over),
            ["stou"] = key(kmps.step_out),
            ["stba"] = key(kmps.step_back),
            ["stin"] = key(kmps.step_into),
            ["revc"] = key(kmps.reverse_continue),
            ["up"] = key(kmps.up),
            ["down"] = key(kmps.down),
            ["rutc"] = key(kmps.run_to_cursor),
            ["rplt"] = key(kmps.repl_toggle),
            ["rpse"] = key(kmps.repl_session),
            ["hov"] = key(kmps.hover),
            ["duit"] = key(kmps.dapui_toggle),
          }
        }
      },
      heads = {
        { "q", nil, { exit = true, desc = "exit" } },
        { kmps.continue, fns.continue, { desc = "continue" } },
        { kmps.run_last, fns.run_last, { desc = "run last configuration" } },
        { kmps.launch, fns.launch, { desc = "launch" } },
        { kmps.terminate, fns.terminate, { desc = "terminate" } },
        { kmps.disconnect, fns.disconnect, { desc = "disconnect" } },
        { kmps.close, fns.close, { desc = "close" } },
        { kmps.set_breakpoint_cond, fns.set_breakpoint_cond, { desc = "set conditional breakpoint" } },
        { kmps.set_breakpoint_log, fns.set_breakpoint_log, { desc = "set log breakpoint" } },
        { kmps.toggle_breakpoint, fns.toggle_breakpoint, { desc = "toggle breakpoint" } },
        { kmps.clear_breakpoints, fns.clear_breakpoints, { desc = "clear breakpoints" } },
        { kmps.step_over, fns.step_over, { desc = "step over" } },
        { kmps.step_into, fns.step_into, { desc = "step into" } },
        { kmps.step_out, fns.step_out, { desc = "step out" } },
        { kmps.step_back, fns.step_back, { desc = "step back" } },
        { kmps.reverse_continue, fns.reverse_continue, { desc = "reverse continue" } },
        { kmps.up, fns.up, { desc = "up" } },
        { kmps.down, fns.down, { desc = "down" } },
        { kmps.run_to_cursor, fns.run_to_cursor, { desc = "run to cursor" } },
        { kmps.repl_toggle, fns.repl_toggle, { desc = "toggle repl" } },
        -- {kmps.repl_session, fns.repl_session , { desc="repl_session"}},
        { kmps.hover, fns.hover, { desc = "hover" } },
        { kmps.dapui_toggle, fns.dapui_toggle, { desc = "toggle dapui" } },
      }
    })
  end,
}

return M
