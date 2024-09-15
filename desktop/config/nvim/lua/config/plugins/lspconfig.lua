local setup_options
local fetch_options

local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
  },
  _options = nil,
  config = function()
    local servers = require("config.plugins.lsp.servers")
    local funcs = require("utils.funcs")

    local lspconfig = require("lspconfig")
    local options = fetch_options()

    -- Setup diagnostics
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

    -- Setup servers
    for server, opts in pairs(servers) do
      opts = vim.tbl_deep_extend("force", {}, options, opts or {})
      lspconfig[server].setup(opts)
    end

    local wk_ok, wk = pcall(require, "which-key")
    if wk_ok then
      wk.add({
        { "<localleader>l", group = "lsp" },
      })
    end

    funcs.set_keynomap("n", "<localleader>li", "<cmd>LspInstall<cr>", "Install")
    funcs.set_keynomap("n", "<localleader>ll", "<cmd>LspLog<cr>", "Install")
    funcs.set_keynomap("n", "<localleader>lr", "<cmd>LspRestart<cr>", "Install")
    funcs.set_keynomap("n", "<localleader>ls", "<cmd>LspInfo<cr>", "Install")
  end,
}

setup_options = function()
  local keymaps = require("config.plugins.lsp.keymaps")

  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
      width = 60,
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
      width = 60,
    })
  }

  local function on_attach(client, bufnr)
    keymaps.on_attach(client, bufnr)
    -- Inlay hints
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr })
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

  M._options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    handlers = handlers,
  }
end

---@return table
fetch_options = function()
  if M._options == nil then
    setup_options()
  end
  return M._options
end

M.fetch_options = fetch_options

return M
