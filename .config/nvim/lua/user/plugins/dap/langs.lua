local dap = require('dap')
local HOME = vim.fn.expand('$HOME')

local M = {}
M.type_to_filetype = {}

-- CXX C RUST {{{1
-----------------------------------------------------------------------------//
dap.adapters.cppdbg = {
  type = 'executable',
  command = HOME .. '/data/cpptools/debugAdapters/bin/OpenDebugAD7',
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

M.type_to_filetype.cppdbg = { "c", "cpp", "rust" }
-- }}}

-- PYTHON {{{1
require('dap-python').setup('~/.venvs/debugpy/bin/python')
-- }}}

-- LUA {{{1
dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host, port = config.port })
end

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= "" then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local val = tonumber(vim.fn.input('Port: '))
      assert(val, "Please provide a port number")
      return val
    end,
  }
}
-- }}}

return M

-- vim:foldmethod=marker
