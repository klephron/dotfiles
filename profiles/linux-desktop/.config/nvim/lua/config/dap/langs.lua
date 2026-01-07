local dap = require('dap')
local HOME = vim.fn.expand('$HOME')

local M = {}

-- type to filetype (for processing launch.json)
M.ttft = {}


function M.setup()
  -- CXX C RUST {{{1
  dap.adapters.cppdbg = {
    type = 'executable',
    command = HOME .. '/.local/share/nvim/mason/bin/OpenDebugAD7',
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

  M.ttft.cppdbg = { "c", "cpp", "rust" }
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
