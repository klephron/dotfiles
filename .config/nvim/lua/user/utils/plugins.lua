local fmt = string.format
local fn = vim.fn


local M = {}



function M.packer_notify(msg, level)
  vim.notify(msg, level, { title = "Packer" })
end

function M.packer_bootstrap(install_path)
  local is_boot = fn.empty(fn.glob(install_path)) > 0
  if is_boot then
    M.packer_notify("Downloading packer.nvim...")
    M.packer_notify(
      fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    )
    vim.cmd('packadd! packer.nvim')
  else
    vim.cmd(fmt('packadd! %s', 'packer.nvim'))
  end
  return is_boot
end

-- automatically install packer


function M.conf(name)
  return require(fmt("%s.%s", us.prefix.plugins, name))
end

function M.block_reload(func)
  if vim.g.packer_compiled_loaded then
    return
  end
  func()
end
return M
