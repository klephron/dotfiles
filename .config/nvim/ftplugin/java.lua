local config = {}

local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  return
end

-- local install_path = vim.fn.expand("$HOME") .. '/.local/share/lsp/jdtls/'
local install_path = vim.fn.expand("$HOME") .. '/Data/jdtls-1.9.0/'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath("cache") .. '/jdtls/workspace/' .. project_name

local jar_path = vim.fn.system("echo -n " .. install_path .. 'plugins/' .. 'org.eclipse.equinox.launcher_*.jar')
-- local jar_path = install_path .. 'plugins/' .. 'org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'

local config_type = install_path .. "./config_linux"

config.cmd = {
  'java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.level=ALL',
  '-noverify',
  '-Xmx1G',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  '-jar', jar_path,
  '-configuration', config_type,
  '-data', workspace_dir,
}

jdtls.start_or_attach(config)
