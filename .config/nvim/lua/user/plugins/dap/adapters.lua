local dap = require('dap')

local HOME = vim.fn.expand('$HOME')

dap.adapters.python = {
  type = 'executable';
  command = HOME .. '/.venvs/debugpy/bin/python',
  args = { '-m', 'debugpy.adapter' };
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = HOME .. '/Data/cpptools/debugAdapters/bin/OpenDebugAD7',
}
