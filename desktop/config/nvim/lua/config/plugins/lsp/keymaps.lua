local M = {}

local KeymapDictionary = require("config.utils.keymaps")

M.keymaps = KeymapDictionary:new({
  -- gf (override file open), gl, go, gp, gq, gs, gy, gz
  g_definition = { "gd" },
  g_declaration = { "gD" },
  g_hover = { "gl" },
  g_implementation = { "gm" },
  g_references = { "gr" },
  g_open_float = { "gh" },
  g_open_float_cursor = { "gH" },

  goto_prev = { "[d", "Goto previous" },
  goto_next = { "]d", "Goto next" },

  definition = { "<leader>kd", "Definition" },
  declaration = { "<leader>ke", "Declaration" },
  hover = { "<leader>kl", "Hover" },
  implementation = { "<leader>ki", "Implementation" },
  signature_help = { "<leader>kk", "Signature help" },
  rename = { "<leader>kn", "Rename" },
  references = { "<leader>kr", "References" },
  code_action = { "<leader>ka", "Code action" },
  open_float = { "<leader>kh", "Open float" },
  open_float_cursor = { "<leader>kH", "Open float under cursor" },
  codelens = { "<leader>km", "Run codelens" },
  type_definition = { "<leader>kp", "Type definition" },

  format = { "<leader>m", "Format file" },
}, "lsp")

function M.on_attach(client, bufnr)
  local kmps = M.keymaps

  local lspsaga_ok = false

  local function with_desc(desc)
    return { buffer = bufnr, desc = kmps:desc(desc) }
  end

  -- definitionProvider
  config.set_keynomap("n", kmps.definition.key, vim.lsp.buf.definition, with_desc("definition"))
  config.set_keynomap("n", kmps.g_definition.key, vim.lsp.buf.definition, with_desc("definition"))

  -- declarationProvider
  config.set_keynomap("n", kmps.declaration.key, vim.lsp.buf.declaration, with_desc("declaration"))
  config.set_keynomap("n", kmps.g_declaration.key, vim.lsp.buf.declaration, with_desc("declaration"))

  -- hoverProvider
  config.set_keynomap("n", kmps.hover.key, vim.lsp.buf.hover, with_desc("hover"))
  config.set_keynomap("n", kmps.g_hover.key, vim.lsp.buf.hover, with_desc("hover"))

  -- implementationProvider
  config.set_keynomap("n", kmps.implementation.key, vim.lsp.buf.implementation, with_desc("implementation"))
  config.set_keynomap("n", kmps.g_implementation.key, vim.lsp.buf.implementation, with_desc("implementation"))

  -- renameProvider
  config.set_keynomap("n", kmps.rename.key, vim.lsp.buf.rename, with_desc("rename"))

  -- referencesProvider
  config.set_keynomap("n", kmps.references.key, vim.lsp.buf.references, with_desc("references"))

  config.set_keynomap("n", kmps.g_references.key, vim.lsp.buf.references, with_desc("references"))

  -- codeActionProvider
  if lspsaga_ok then
    config.set_keynomap("n", kmps.code_action.key, "<cmd>Lspsaga code_action<cr>", with_desc("code_action"))
  else
    config.set_keynomap("n", kmps.code_action.key, vim.lsp.buf.code_action, with_desc("code_action"))
  end
  -- us.set_keynomap("n", kmps.code_action.key, vim.lsp.buf.range_code_action, with_desc("code_action")) deprecated
  --
  -- signatureHelpProvider
  config.set_keynomap("n", kmps.signature_help.key, vim.lsp.buf.signature_help, with_desc("signature_help"))

  -- typeDefinitionProvider
  config.set_keynomap("n", kmps.type_definition.key, vim.lsp.buf.type_definition, with_desc("type_definition"))

  -- codeLensProvider
  config.set_keynomap("n", kmps.codelens.key, vim.lsp.codelens.run, with_desc("codelens"))

  -- documentSymbolProvider

  -- documentFormattingProvider
  config.set_keynomap("n", kmps.format.key, function() vim.lsp.buf.format({ async = true }) end,
    with_desc(("format")))

  -- Diagnostics
  config.set_keynomap("n", kmps.open_float.key, '<cmd>lua vim.diagnostic.open_float()<cr>',
    with_desc("open_float"))
  config.set_keynomap("n", kmps.g_open_float.key, '<cmd>lua vim.diagnostic.open_float()<cr>',
    with_desc("open_float"))
  config.set_keynomap("n", kmps.goto_next.key, '<cmd>lua vim.diagnostic.goto_next()<cr>',
    with_desc("goto_next"))
  config.set_keynomap("n", kmps.goto_prev.key, '<cmd>lua vim.diagnostic.goto_prev()<cr>',
    with_desc("goto_prev"))
end

return M
