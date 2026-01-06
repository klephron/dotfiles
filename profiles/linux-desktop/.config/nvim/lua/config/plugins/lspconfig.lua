local M;

M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
  },
  _options = nil,
  config = function()
    local funcs = require("utils.funcs")

    M.diagnostics_configure()

    funcs.set_keynomap("n", "<localleader>kI", "<cmd>LspInstall<cr>", "Install LSP")
    funcs.set_keynomap("n", "<localleader>kl", "<cmd>LspLog<cr>", "Log LSP")
    funcs.set_keynomap("n", "<localleader>kr", "<cmd>LspRestart<cr>", "Restart LSP")
    funcs.set_keynomap("n", "<localleader>ki", "<cmd>LspInfo<cr>", "Info LSP")
    funcs.set_keynomap("n", "<localleader>ks", "<cmd>LspStart<cr>", "Start LSP")
    funcs.set_keynomap("n", "<localleader>kt", "<cmd>LspStop<cr>", "Stop LSP")
  end,
}

M.on_attach = function(client, bufnr)
  local keymaps = require("config.plugins.lsp.keymaps")

  keymaps.on_attach(client, bufnr)
end

M._options_get = function()
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  local handlers = {
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

  return {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    handlers = handlers,
  }
end

---@return table
M.options_fetch = function()
  if M._options == nil then
    M._options = M._options_get()
  end
  return M._options
end

M.diagnostics_configure = function()
  local diagnostics_icons = require("config.icons").diagnostics
  local diagnostics_signs = {
    Error = diagnostics_icons.error,
    Warn = diagnostics_icons.warn,
    Hint = diagnostics_icons.hint,
    Info = diagnostics_icons.info
  }

  vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    -- virtual_text = { spacing = 2, prefix = "●", format = function(diagnostic)
    --   local STR_MAX_SIZE = 30
    --   local mes = string.format("%s", diagnostic.message)
    --   if mes:len() > STR_MAX_SIZE then
    --     return mes:sub(1, STR_MAX_SIZE - 3) .. "..."
    --   end
    --   return mes
    -- end
    -- },
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    }
  })

  for type, icon in pairs(diagnostics_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { texthl = hl, text = icon, numhl = "" })
  end
end

M._servers_config = function(servers)
  local options = M.options_fetch()

  -- default
  vim.lsp.config("*", vim.tbl_deep_extend("force", {}, options, { on_attach = M.on_attach }))

  -- specific server configurations
  for server, server_options in pairs(servers) do
    server_options = vim.tbl_deep_extend("force", {}, options, server_options or {})

    local server_on_attach = server_options.on_attach

    if server_on_attach then
      server_options.on_attach = function(client, bufnr)
        M.on_attach(client, bufnr)
        server_on_attach(client, bufnr)
      end
    else
      server_options.on_attach = M.on_attach
    end

    vim.lsp.config(server, server_options)
  end
end

M.servers_config = function()
  M._servers_config(require("config.plugins.lsp.servers"))
  M._servers_config(require("config.plugins.lsp.servers-local"))
end

M._servers_enable = function(servers)
  for server, _ in pairs(servers) do
    vim.lsp.enable(server, true)
  end
end

M.servers_enable = function()
  M._servers_enable(require("config.plugins.lsp.servers"))
  M._servers_enable(require("config.plugins.lsp.servers-local"))
end

return M
