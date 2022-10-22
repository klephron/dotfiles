local hydra = require("hydra")
local which_key_ok, which_key = pcall(require, "which-key")

local M = {}

local function hydra_notify(msg, level)
  vim.notify(msg, level, { title = "Dap" })
end

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
    local fns = require("user.configs.dap.funcs")

    if which_key_ok then which_key.register({
        [kmps.body.key] = "hydra: Dap body",
      })
    end

    hydra({
      name = "dap hydra",
      mode = "n",
      body = kmps:key("body"),
      hint = dap_hint,
      config = {
        exit = false,
        foreign_keys = "run",
        buffer = false,
        invoke_on_body = true,
        on_enter = function()
          hydra_notify("Entered dap hydra")
        end,
        on_exit = function()
          hydra_notify("Exited dap hydra")
        end,
        timeout = false,
        hint = false,
        --[[ hint = {
          type = "window",
          position = "bottom",
          offset = 0,
          border = "rounded",
          show_name = true,
          funcs = {
            ["quit"] = key(kmps.quit.key),
            ["cont"] = key(kmps.continue.key),
            ["runl"] = key(kmps.run_last.key),
            -- ["lnch"] = key(kmps.process_launchjs.key),
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
        } ]]
      },
      heads = {
        { kmps.quit.key, nil, { exit = true, desc = kmps:desc("quit")} },
        { kmps.body.key, nil, { exit = true, desc = kmps:desc("quit")} },
        { kmps.continue.key, fns.continue, { desc = kmps:desc("continue")} },
        { kmps.run_last.key, fns.run_last, { desc = kmps:desc("run_last")} },
        -- { kmps.process_launchjs.key, fns.process_launchjs_ask, { desc = kmps:desc("process_launchjs")} },
        { kmps.terminate.key, fns.terminate, { desc = kmps:desc("terminate")} },
        { kmps.disconnect.key, fns.disconnect, { desc = kmps:desc("disconnect")} },
        -- { kmps.close.key, fns.close, { desc = kmps:desc("close")} },
        { kmps.set_breakpoint_cond.key, fns.set_breakpoint_cond, { desc = kmps:desc("set_breakpoint_cond")} },
        { kmps.set_breakpoint_log.key, fns.set_breakpoint_log, { desc = kmps:desc("set_breakpoint_log")} },
        { kmps.toggle_breakpoint.key, fns.toggle_breakpoint, { desc = kmps:desc("toggle_breakpoint")} },
        { kmps.clear_breakpoints.key, fns.clear_breakpoints, { desc = kmps:desc("clear_breakpoints")} },
        { kmps.step_over.key, fns.step_over, { desc = kmps:desc("step_over")} },
        { kmps.step_into.key, fns.step_into, { desc = kmps:desc("step_into")} },
        { kmps.step_out.key, fns.step_out, { desc = kmps:desc("step_out")} },
        { kmps.step_back.key, fns.step_back, { desc = kmps:desc("step_back")} },
        { kmps.reverse_continue.key, fns.reverse_continue, { desc = kmps:desc("reverse_continue")} },
        { kmps.up.key, fns.up, { desc = kmps:desc("up")} },
        { kmps.down.key, fns.down, { desc = kmps:desc("down")} },
        { kmps.run_to_cursor.key, fns.run_to_cursor, { desc = kmps:desc("run_to_cursor")} },
        { kmps.repl_toggle.key, fns.repl_toggle, { desc = kmps:desc("repl_toggle")} },
        -- {kmps.repl_session.key, fns.repl_session , { desc= kms:desc("repl_session")}},
        { kmps.hover.key, fns.hover, { desc = kmps:desc("hover")} },
        { kmps.dapui_toggle.key, fns.dapui_toggle, { desc = kmps:desc("dapui_toggle")} },
      }
    })
  end,
}

return M
