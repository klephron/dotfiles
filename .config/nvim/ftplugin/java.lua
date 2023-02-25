local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  return
end

local options = conf_require("lsp.lspconfig").options

local opts = {}

local install_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"
-- local install_path = vim.fn.expand("$HOME") .. '/Data/jdtls-1.9.0/'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath("cache") .. '/jdtls/workspace/' .. project_name

local jar_path = vim.fn.system("echo -n " .. install_path .. 'plugins/' .. 'org.eclipse.equinox.launcher_*.jar')
-- local jar_path = install_path .. 'plugins/' .. 'org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'

local config_type = install_path .. "./config_linux"

opts = {
  cmd = {
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
  },
}

opts = vim.tbl_deep_extend("force", {}, options, opts or {})


jdtls.start_or_attach(opts)
