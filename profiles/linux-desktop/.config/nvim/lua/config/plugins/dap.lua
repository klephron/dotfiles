local M;

local dap = require("dap")
local widgets = require("dap.ui.widgets")
local home = vim.fn.expand('$HOME')
local kmps_dict = require("utils.kmps_dict").KeymapDictionary
local utils = require("utils.funcs")

local kmps_dap
local kmps_dap_fn
local launchjs_paths
local is_launchjs_ok
local ttft
local funcs
local dap_notify
local process_launchjs
local keymaps_setup
local langs_setup

M = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    vim.api.nvim_set_hl(0, 'DapBreakpoint',
      { ctermbg = 0, fg = "#e41400", bg = nil }
    )
    vim.api.nvim_set_hl(0, 'DapStopped',
      { ctermbg = 0, fg = nil, bg = "#022e4b" }
    )

    vim.fn.sign_define('DapBreakpoint',
      {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = ''
      })
    vim.fn.sign_define('DapBreakpointCondition',
      {
        text = 'ﳁ',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = ''
      })
    vim.fn.sign_define('DapBreakpointRejected',
      {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = ''
      })
    vim.fn.sign_define('DapLogPoint', {
      text = '',
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = ''
    })
    vim.fn.sign_define('DapStopped',
      {
        text = '→',
        texthl = 'DapStopped',
        linehl = 'DapStopped',
        numhl = 'DapStopped'
      })

    keymaps_setup()
    langs_setup()
  end
}

kmps_dap = kmps_dict:new({
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
}, "")

kmps_dap_fn = kmps_dict:new({
  step_into = { "<F1>", "Step into" },
  step_over = { "<F2>", "Step over" },
  step_out = { "<F3>", "Step out" },
  run_to_cursor = { "<F4>", "Run to cursor", },
  step_back = { "<F5>", "Step back" },

  hover = { "<F6>", "Open hover" },

  run_last = { "<F7>", "Run last" },
  continue = { "<F8>", "Continue" },

  toggle_breakpoint = { "<F9>", "Toggle breakpoint" },
  clear_breakpoints = { "<F33>", "Clear breakpoints" }, -- Ctrl + <F9>

  terminate = { "<F10>", "Terminate" },
}, "")


launchjs_paths = {
  'launch.json',
  '.vscode/launch.json',
}

is_launchjs_ok = nil

ttft = {}

funcs = {
  continue = function()
    -- Force load dap-ui
    require("dapui")
    if is_launchjs_ok == nil then
      is_launchjs_ok = process_launchjs({ ask = false })
    end
    return dap.continue()
  end,

  run_last = function()
    return dap.run_last()
  end,

  process_launchjs_ask = function()
    return process_launchjs({ ask = true })
  end,

  terminate = function()
    return dap.terminate()
  end,

  disconnect = function()
    return dap.disconnect()
  end,

  close = function()
    return dap.close()
  end,

  set_breakpoint_cond = function()
    return dap.set_breakpoint(vim.fn.input("[Condition]: "))
  end,

  set_breakpoint_log = function()
    return dap.set_breakpoint(nil, nil, vim.fn.input('[Log message]: '))
  end,

  toggle_breakpoint = function()
    return dap.toggle_breakpoint()
  end,

  clear_breakpoints = function()
    return dap.clear_breakpoints()
  end,

  step_over = function()
    return dap.step_over()
  end,

  step_into = function()
    return dap.step_into()
  end,

  step_out = function()
    return dap.step_out()
  end,

  step_back = function()
    return dap.step_back()
  end,

  reverse_continue = function()
    return dap.reverse_continue()
  end,

  up = function()
    return dap.up()
  end,

  down = function()
    return dap.down()
  end,

  run_to_cursor = function()
    return dap.run_to_cursor()
  end,

  repl_toggle = function()
    -- local height = vim.fn.winwidth(vim.fn.win_getid())
    local h = vim.api.nvim_win_get_height(0)
    return dap.repl.toggle({ height = math.floor(h * 0.3) }, "belowright split")
  end,

  hover = function()
    return widgets.hover()
  end,

  dapui_toggle = function()
    return require("dapui").toggle({ reset = true })
  end,
}


dap_notify = function(msg, level)
  vim.notify(msg, level, { title = "Dap" })
end

---Process launchjs.json
---@param opts table|nil
---ask nil|boolean
---@return boolean
process_launchjs = function(opts)
  opts = opts or {}
  local path = nil
  for _, ipath in ipairs(launchjs_paths) do
    local resolved_path = vim.fn.getcwd() .. '/' .. ipath
    if vim.loop.fs_stat(resolved_path) then
      path = resolved_path
      break
    end
  end
  if path == nil then
    if opts.ask then
      path = vim.fn.input('Path to launch.json: ', vim.fn.getcwd() .. '/', 'file')
      if not vim.loop.fs_stat(path) then
        dap_notify("Not resolved path: " .. path .. "\nReturning...", vim.log.levels.ERROR)
        return false
      end
    else
      return false
    end
  end

  local ok, result = pcall(require("dap.ext.vscode").load_launchjs, path, ttft)
  if ok then
    dap_notify("Resolved launch.json path: " .. path, vim.log.levels.INFO)
  else
    dap_notify(result, vim.log.levels.ERROR)
  end
  return ok
end


keymaps_setup = function()
  utils.set_keynomap("n", kmps_dap.continue.key, funcs.continue, kmps_dap:desc("continue"))
  utils.set_keynomap("n", kmps_dap.run_last.key, funcs.run_last, kmps_dap:desc("run_last"))
  utils.set_keynomap("n", kmps_dap.process_launchjs.key, funcs.process_launchjs_ask, kmps_dap:desc("process_launchjs"))
  utils.set_keynomap("n", kmps_dap.terminate.key, funcs.terminate, kmps_dap:desc("terminate"))
  utils.set_keynomap("n", kmps_dap.disconnect.key, funcs.disconnect, kmps_dap:desc("disconnect"))
  -- us.set_keynomap("n", kmps_dap.close.key, funcs.close, kmps_dap:desc("close"))
  utils.set_keynomap("n", kmps_dap.set_breakpoint_cond.key, funcs.set_breakpoint_cond,
    kmps_dap:desc("set_breakpoint_cond"))
  utils.set_keynomap("n", kmps_dap.set_breakpoint_log.key, funcs.set_breakpoint_log, kmps_dap:desc("set_breakpoint_log"))
  utils.set_keynomap("n", kmps_dap.toggle_breakpoint.key, funcs.toggle_breakpoint, kmps_dap:desc("toggle_breakpoint"))
  utils.set_keynomap("n", kmps_dap.clear_breakpoints.key, funcs.clear_breakpoints, kmps_dap:desc("clear_breakpoints"))
  utils.set_keynomap("n", kmps_dap.step_over.key, funcs.step_over, kmps_dap:desc("step_over"))
  utils.set_keynomap("n", kmps_dap.step_into.key, funcs.step_into, kmps_dap:desc("step_into"))
  utils.set_keynomap("n", kmps_dap.step_out.key, funcs.step_out, kmps_dap:desc("step_out"))
  utils.set_keynomap("n", kmps_dap.step_back.key, funcs.step_back, kmps_dap:desc("step_back"))
  -- us.set_keynomap("n", kmps_dap.pause.key, dap.pause, kmps_dap:desc("pause"))
  utils.set_keynomap("n", kmps_dap.reverse_continue.key, funcs.reverse_continue, kmps_dap:desc("reverse_continue"))
  utils.set_keynomap("n", kmps_dap.up.key, funcs.up, kmps_dap:desc("up"))
  utils.set_keynomap("n", kmps_dap.down.key, funcs.down, kmps_dap:desc("down"))
  utils.set_keynomap("n", kmps_dap.run_to_cursor.key, funcs.run_to_cursor, kmps_dap:desc("run_to_cursor"))
  utils.set_keynomap("n", kmps_dap.repl_toggle.key, funcs.repl_toggle, kmps_dap:desc("repl_toggle"))
  -- us.set_keynomap("n", kmps_dap.repl_session.key, dap.repl.session, kmps_dap:desc("repl_session"))
  utils.set_keynomap("n", kmps_dap.hover.key, funcs.hover, kmps_dap:desc("hover"))
  utils.set_keynomap("n", kmps_dap.dapui_toggle.key, funcs.dapui_toggle, kmps_dap:desc("dapui_toggle"))

  -- Bind FN mappings for dap
  utils.set_keynomap("n", kmps_dap_fn.step_over.key, funcs.step_over, kmps_dap_fn:desc("step_over"))
  utils.set_keynomap("n", kmps_dap_fn.step_into.key, funcs.step_into, kmps_dap_fn:desc("step_into"))
  utils.set_keynomap("n", kmps_dap_fn.step_out.key, funcs.step_out, kmps_dap_fn:desc("step_out"))
  utils.set_keynomap("n", kmps_dap_fn.step_back.key, funcs.step_back, kmps_dap_fn:desc("step_back"))
  utils.set_keynomap("n", kmps_dap_fn.run_to_cursor.key, funcs.run_to_cursor, kmps_dap_fn:desc("run_to_cursor"))

  utils.set_keynomap("n", kmps_dap_fn.continue.key, funcs.continue, kmps_dap_fn:desc("continue"))
  utils.set_keynomap("n", kmps_dap_fn.run_last.key, funcs.run_last, kmps_dap_fn:desc("run_last"))
  utils.set_keynomap("n", kmps_dap_fn.terminate.key, funcs.terminate, kmps_dap_fn:desc("terminate"))

  utils.set_keynomap("n", kmps_dap_fn.toggle_breakpoint.key, funcs.toggle_breakpoint,
    kmps_dap_fn:desc("toggle_breakpoint"))
  utils.set_keynomap("n", kmps_dap_fn.clear_breakpoints.key, funcs.clear_breakpoints,
    kmps_dap_fn:desc("clear_breakpoints"))

  utils.set_keynomap("n", kmps_dap_fn.hover.key, funcs.hover, kmps_dap_fn:desc("hover"))
end

langs_setup = function()
  -- CXX C RUST {{{1
  dap.adapters.cppdbg = {
    type = 'executable',
    command = home .. '/.local/share/nvim/mason/bin/OpenDebugAD7',
    id = 'cppdbg', -- used in initialized request
    enrich_config = function(config, on_config)
      if config.preLaunchTask then
        vim.fn.jobstart(config.preLaunchTask, {
          on_exit = function()
            on_config(config)
          end
        })
      else
        on_config(config)
      end
    end
  }


  dap.configurations.cpp = {
    {
      name = "[base]: launch `path-to-executable`",
      type = "cppdbg",
      request = "launch",
      -- opts
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopAtEntry = true,
    },
    {
      name = '[base]: attach gdbserver :1234 `path-to-executable`',
      type = 'cppdbg',
      request = 'launch',
      -- opts
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      linux = {
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
      },
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  ttft.cppdbg = { "c", "cpp", "rust" }
  -- }}}

  -- PYTHON {{{1
  require('dap-python').setup('~/Data/venvs/debugpy/bin/python')

  --[[ dap.adapters.python = {
    type = 'executable';
    command = HOME .. '/.venvs/debugpy/bin/python',
    args = { '-m', 'debugpy.adapter' };
  }
  dap.configurations.python = {
    {
      type = 'python';
      request = 'launch';
      name = "Launch file";

      program = "${file}";
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        else
          return '/usr/bin/python'
        end
      end;
    },
  } ]]
  -- }}}
end

return M

-- vim:foldmethod=marker
