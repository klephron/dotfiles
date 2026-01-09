local M = {}

function M.on_attach(client, bufnr)
  local funcs = require("utils.funcs")

  local lspsaga_ok = false

  local function wrap(desc)
    return { buffer = bufnr, desc = desc, nowait = true }
  end

  -- definitionProvider
  funcs.set_keynomap("n", "<leader>kd", vim.lsp.buf.definition, wrap("Goto definition"))
  funcs.set_keynomap("n", "gd", vim.lsp.buf.definition, wrap("Goto definition"))

  -- declarationProvider
  funcs.set_keynomap("n", "<leader>kf", vim.lsp.buf.declaration, wrap("Goto declaration"))
  funcs.set_keynomap("n", "gf", vim.lsp.buf.declaration, wrap("Goto declaration"))

  -- hoverProvider
  funcs.set_keynomap("n", "<leader>kl", function() vim.lsp.buf.hover({ border = "single", width = 80 }) end,
    wrap("Open hover"))
  funcs.set_keynomap("n", "gl", function() vim.lsp.buf.hover({ border = "single", width = 80 }) end,
    wrap("Open hover"))

  -- implementationProvider
  funcs.set_keynomap("n", "<leader>ki", vim.lsp.buf.implementation, wrap("Goto implementation"))
  funcs.set_keynomap("n", "gm", vim.lsp.buf.implementation, wrap("Goto implementation"))

  -- renameProvider
  funcs.set_keynomap("n", "<leader>kn", vim.lsp.buf.rename, wrap("Rename"))

  -- referencesProvider
  funcs.set_keynomap("n", "<leader>kr", vim.lsp.buf.references, wrap("List references"))
  funcs.set_keynomap("n", "gr", vim.lsp.buf.references, wrap("List references"))

  -- codeActionProvider
  if lspsaga_ok then
    funcs.set_keynomap("n", "<leader>ka", "<cmd>Lspsaga code_action<cr>", wrap("Open code action"))
  else
    funcs.set_keynomap("n", "<leader>ka", vim.lsp.buf.code_action, wrap("Open code action"))
  end

  -- signatureHelpProvider
  funcs.set_keynomap("n", "<leader>kk",
    function() vim.lsp.buf.signature_help({ border = "single", width = 80 }) end,
    wrap("Open signature help"))

  -- typeDefinitionProvider
  funcs.set_keynomap("n", "<leader>kp", vim.lsp.buf.type_definition, wrap("Goto type definition"))
  funcs.set_keynomap("n", "gp", vim.lsp.buf.type_definition, wrap("Goto type definition"))

  -- codeLensProvider
  funcs.set_keynomap("n", "<leader>kc", vim.lsp.codelens.run, wrap("Run codelens"))

  -- documentSymbolProvider

  -- documentFormattingProvider
  --[[ -- handled by conform-nvim
  funcs.set_keynomap("n", kmps.format.key, function() vim.lsp.buf.format({ async = true }) end,
  with_desc(("format"))) ]]

  -- selectionRangeProvider
  funcs.set_keynomap('x', 'an', function() vim.lsp.buf.selection_range('outer') end,
    wrap("vim.lsp.buf.selection_range('outer')"))
  funcs.set_keynomap('x', 'in', function() vim.lsp.buf.selection_range('inner') end,
    wrap("vim.lsp.buf.selection_range('inner')"))

  -- Diagnostics
  funcs.set_keynomap("n", "<leader>kh", vim.diagnostic.open_float, wrap("Open float"))
  funcs.set_keynomap("n", "gh", vim.diagnostic.open_float, wrap("Open float"))
  funcs.set_keynomap("n", "[d", vim.diagnostic.goto_prev, wrap("Goto previous diagnostics"))
  funcs.set_keynomap("n", "]d", vim.diagnostic.goto_next, wrap("Goto next diagnostics"))

  -- inlayHint
  funcs.set_keynomap("n", "<localleader>kh",
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      vim.notify("inlay hints " ..
        (vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"), vim.log.levels.INFO, { title = "lsp" })
    end,
    "Toggle inlay hints")
end

return M
