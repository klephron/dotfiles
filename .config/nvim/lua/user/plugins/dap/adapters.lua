local dap = require('dap')

dap.adapters.python = {
  type = 'executable';
  command = vim.fn.expand('~/.venvs/debugpy/bin/python'),
  args = { '-m', 'debugpy.adapter' };
}
