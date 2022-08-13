local M = {}

local hydra = require("hydra")

local function key(kmp)
  return function() return kmp end
end

local dap_hint = [[
                                           ^^^^^^^^^^^^^^^^^^^^^^^DAP HYDRA:
 ^^^_%{runl}_: run last       ^_%{down}_: down                               ^^^^^^^^_%{togb}_: toggle break       _%{stin}_: step into 
 ^^^_%{lnch}_: launchjs       ^^^_%{up}_: up                ^_%{hov}_: hover         ^_%{sbc}_: conditional break  _%{stou}_: step out  
 ^^^_%{term}_: terminate       _%{cont}_: continue          _%{rplt}_: toggle REPL   ^_%{sbl}_: log break          _%{stov}_: step over 
 ^^^_%{disc}_: disconnect      _%{revc}_: reverse continue  _%{duit}_: toggle dapui  _%{clrb}_: clear breaks       _%{stba}_: step back 
     _%{cls}_: close           _%{rutc}_: run to cursor                                            ^^^^^^^^^^^^^^^^^^^^^^_%{quit}_: exit 
]]

M.hydras = {
  dap = function()
    local kmps = require("user.keymaps").dap_hydra
    local fns = require("user.plugins.dap.funcs")
    hydra({
      name = "Dap hydra",
      mode = "n",
      body = kmps:key("body"),
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
            ["quit"] = key(kmps.quit.key),
            ["cont"] = key(kmps.continue.key),
            ["runl"] = key(kmps.run_last.key),
            ["lnch"] = key(kmps.process_launchjs.key),
            ["term"] = key(kmps.terminate.key),
            ["disc"] = key(kmps.disconnect.key),
            ["cls"]  = key(kmps.close.key),
            ["sbc"]  = key(kmps.set_breakpoint_cond.key),
            ["sbl"]  = key(kmps.set_breakpoint_log.key),
            ["togb"] = key(kmps.toggle_breakpoint.key),
            ["clrb"] = key(kmps.clear_breakpoints.key),
            ["stov"] = key(kmps.step_over.key),
            ["stou"] = key(kmps.step_out.key),
            ["stba"] = key(kmps.step_back.key),
            ["stin"] = key(kmps.step_into.key),
            ["revc"] = key(kmps.reverse_continue.key),
            ["up"]   = key(kmps.up.key),
            ["down"] = key(kmps.down.key),
            ["rutc"] = key(kmps.run_to_cursor.key),
            ["rplt"] = key(kmps.repl_toggle.key),
            ["rpse"] = key(kmps.repl_session.key),
            ["hov"]  = key(kmps.hover.key),
            ["duit"] = key(kmps.dapui_toggle.key),
          }
        }
      },
      heads = {
        { kmps.quit.key, nil, { exit = true, desc = kmps.quit.desc } },
        { kmps.continue.key, fns.continue, { desc = kmps.continue.desc } },
        { kmps.run_last.key, fns.run_last, { desc = kmps.run_last.desc } },
        { kmps.process_launchjs.key, fns.process_launchjs, { desc = kmps.process_launchjs.desc } },
        { kmps.terminate.key, fns.terminate, { desc = kmps.terminate.desc } },
        { kmps.disconnect.key, fns.disconnect, { desc = kmps.disconnect.desc } },
        { kmps.close.key, fns.close, { desc = kmps.close.desc } },
        { kmps.set_breakpoint_cond.key, fns.set_breakpoint_cond, { desc = kmps.set_breakpoint_cond.desc } },
        { kmps.set_breakpoint_log.key, fns.set_breakpoint_log, { desc = kmps.set_breakpoint_log.desc } },
        { kmps.toggle_breakpoint.key, fns.toggle_breakpoint, { desc = kmps.toggle_breakpoint.desc } },
        { kmps.clear_breakpoints.key, fns.clear_breakpoints, { desc = kmps.clear_breakpoints.desc } },
        { kmps.step_over.key, fns.step_over, { desc = kmps.step_over.desc } },
        { kmps.step_into.key, fns.step_into, { desc = kmps.step_into.desc } },
        { kmps.step_out.key, fns.step_out, { desc = kmps.step_out.desc } },
        { kmps.step_back.key, fns.step_back, { desc = kmps.step_back.desc } },
        { kmps.reverse_continue.key, fns.reverse_continue, { desc = kmps.reverse_continue.desc } },
        { kmps.up.key, fns.up, { desc = kmps.up.desc } },
        { kmps.down.key, fns.down, { desc = kmps.down.desc } },
        { kmps.run_to_cursor.key, fns.run_to_cursor, { desc = kmps.run_to_cursor.desc } },
        { kmps.repl_toggle.key, fns.repl_toggle, { desc = kmps.repl_toggle.desc } },
        -- {kmps.repl_session.key, fns.repl_session , { desc= kms.repl_session.desc}},
        { kmps.hover.key, fns.hover, { desc = kmps.hover.desc } },
        { kmps.dapui_toggle.key, fns.dapui_toggle, { desc = kmps.dapui_toggle.desc } },
      }
    })
  end,
}

return M
