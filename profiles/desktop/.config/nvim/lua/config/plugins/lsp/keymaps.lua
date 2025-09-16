local M = {}

local KeymapDictionary = require("utils.kmps_dict").KeymapDictionary

M.keymaps = KeymapDictionary:new({
  -- gf (override file open), gl, go, gp, gq, gs, gy, gz
  g_definition = { "gd" },
  g_declaration = { "gf" },
  g_hover = { "gl" },
  g_implementation = { "gm" },
  g_references = { "gr" },
  g_open_float = { "gh" },
  g_open_float_cursor = { "gH" },
  g_type_definition = { "gp" },

  goto_prev = { "[d", "Goto previous diagnostics" },
  goto_next = { "]d", "Goto next diagnostics" },

  definition = { "<leader>kd", "Goto definition" },
  declaration = { "<leader>kf", "Goto declaration" },
  hover = { "<leader>kl", "Open hover" },
  implementation = { "<leader>ki", "Goto implementation" },
  signature_help = { "<leader>kk", "Open signature help" },
  rename = { "<leader>kn", "Rename" },
  references = { "<leader>kr", "List references" },
  code_action = { "<leader>ka", "Open code action" },
  open_float = { "<leader>kh", "Open float" },
  open_float_cursor = { "<leader>kH", "Open float under cursor" },
  codelens = { "<leader>kc", "Run codelens" },
  type_definition = { "<leader>kp", "Goto type definition" },

  format = { "<leader>km", "Format buffer" },

  inlay_hint = { "<localleader>kt", "Toggle inlay hints" },
}, "")

function M.on_attach(client, bufnr)
  local kmps = M.keymaps
  local funcs = require("utils.funcs")

  local lspsaga_ok = false

  local function with_desc(desc)
    return { buffer = bufnr, desc = kmps:desc(desc), nowait = true }
  end

  -- definitionProvider
  funcs.set_keynomap("n", kmps.definition.key, vim.lsp.buf.definition, with_desc("definition"))
  funcs.set_keynomap("n", kmps.g_definition.key, vim.lsp.buf.definition, with_desc("definition"))

  -- declarationProvider
  funcs.set_keynomap("n", kmps.declaration.key, vim.lsp.buf.declaration, with_desc("declaration"))
  funcs.set_keynomap("n", kmps.g_declaration.key, vim.lsp.buf.declaration, with_desc("declaration"))

  -- hoverProvider
  funcs.set_keynomap("n", kmps.hover.key, function() vim.lsp.buf.hover({ border = "single", width = 80 }) end,
    with_desc("hover"))
  funcs.set_keynomap("n", kmps.g_hover.key, function() vim.lsp.buf.hover({ border = "single", width = 80 }) end,
    with_desc("hover"))

  -- implementationProvider
  funcs.set_keynomap("n", kmps.implementation.key, vim.lsp.buf.implementation, with_desc("implementation"))
  funcs.set_keynomap("n", kmps.g_implementation.key, vim.lsp.buf.implementation, with_desc("implementation"))

  -- renameProvider
  funcs.set_keynomap("n", kmps.rename.key, vim.lsp.buf.rename, with_desc("rename"))

  -- referencesProvider
  funcs.set_keynomap("n", kmps.references.key, vim.lsp.buf.references, with_desc("references"))

  funcs.set_keynomap("n", kmps.g_references.key, vim.lsp.buf.references, with_desc("references"))

  -- codeActionProvider
  if lspsaga_ok then
    funcs.set_keynomap("n", kmps.code_action.key, "<cmd>Lspsaga code_action<cr>", with_desc("code_action"))
  else
    funcs.set_keynomap("n", kmps.code_action.key, vim.lsp.buf.code_action, with_desc("code_action"))
  end
  -- us.set_keynomap("n", kmps.code_action.key, vim.lsp.buf.range_code_action, with_desc("code_action")) deprecated
  --
  -- signatureHelpProvider
  funcs.set_keynomap("n", kmps.signature_help.key,
    function() vim.lsp.buf.signature_help({ border = "single", width = 80 }) end,
    with_desc("signature_help"))

  -- typeDefinitionProvider
  funcs.set_keynomap("n", kmps.type_definition.key, vim.lsp.buf.type_definition, with_desc("type_definition"))
  funcs.set_keynomap("n", kmps.g_type_definition.key, vim.lsp.buf.type_definition, with_desc("type_definition"))

  -- codeLensProvider
  funcs.set_keynomap("n", kmps.codelens.key, vim.lsp.codelens.run, with_desc("codelens"))

  -- documentSymbolProvider

  -- documentFormattingProvider
  --[[ -- handled by conform-nvim
  funcs.set_keynomap("n", kmps.format.key, function() vim.lsp.buf.format({ async = true }) end,
  with_desc(("format"))) ]]

  -- Diagnostics
  funcs.set_keynomap("n", kmps.open_float.key, '<cmd>lua vim.diagnostic.open_float()<cr>',
    with_desc("open_float"))
  funcs.set_keynomap("n", kmps.g_open_float.key, '<cmd>lua vim.diagnostic.open_float()<cr>',
    with_desc("open_float"))
  funcs.set_keynomap("n", kmps.goto_next.key, '<cmd>lua vim.diagnostic.goto_next()<cr>',
    with_desc("goto_next"))
  funcs.set_keynomap("n", kmps.goto_prev.key, '<cmd>lua vim.diagnostic.goto_prev()<cr>',
    with_desc("goto_prev"))

  -- Hints
  funcs.set_keynomap("n", kmps.inlay_hint.key,
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      vim.notify("inlay hints " ..
        (vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"), vim.log.levels.INFO, { title = "lsp" })
    end,
    with_desc("inlay_hint"))
end

return M
