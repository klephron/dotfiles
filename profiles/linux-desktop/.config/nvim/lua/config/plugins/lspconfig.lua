local M;

local keymaps_on_attach;
local servers;
local servers_local;

M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
  },
  _options = nil,
  config = function()
    local funcs = require("utils.funcs")

    M.diagnostics_configure()

    funcs.set_keynomap("n", "<localleader>kd", "<cmd>lsp disable<cr>", "Disable LSP")
    funcs.set_keynomap("n", "<localleader>ke", "<cmd>lsp enable<cr>", "Enable LSP")
    funcs.set_keynomap("n", "<localleader>ki", "<cmd>LspInstall<cr>", "Install LSP")
    funcs.set_keynomap("n", "<localleader>kr", "<cmd>lsp restart<cr>", "Restart LSP")
    funcs.set_keynomap("n", "<localleader>ks", "<cmd>checkhealth lsp<cr>", "Info LSP")
    funcs.set_keynomap("n", "<localleader>kt", "<cmd>lsp stop<cr>", "Stop LSP")
  end,
}

M.on_attach = function(client, bufnr)
  keymaps_on_attach(client, bufnr)
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

M._servers_enable = function(servers)
  for server, _ in pairs(servers) do
    vim.lsp.enable(server, true)
  end
end

M.servers_config = function()
  M._servers_config(servers)
  M._servers_config(servers_local)
end

M.servers_enable = function()
  M._servers_enable(servers)
  -- M._servers_enable(require(servers_local))
end

keymaps_on_attach = function(client, bufnr)
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

servers = {
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    single_file_support = true,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        format = {
          enable = true,
        },
        hint = {
          enable = true,
        },
        semantic = {
          enable = false,
          variable = false,
        }
      },
    },
  },
  clangd = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
      },
    },
    capabilities = {
      offsetEncoding = { "utf-16", "utf-8" },
    }
  },
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    single_file_support = true,
  },
  rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    settings = {
      ["rust-analyzer"] = {
        -- cachePriming = {
        --   enable = false
        -- },
        -- assist = {
        --   importEnforceGranularity = true,
        --   importPrefix = 'crate',
        -- },
        -- cargo = {
        --   features = "all",
        --   sysrootQueryMetadata = true,
        -- },
        checkOnSave = {
          command = 'check', -- used clippy, but it is really slow
        },
        -- inlayHints = {
        --   bindingModeHints = {
        --     enable = false,
        --   },
        --   chainingHints = {
        --     enable = true,
        --   },
        --   closingBraceHints = {
        --     enable = true,
        --     minLines = 25,
        --   },
        --   closureReturnTypeHints = {
        --     enable = "never",
        --   },
        --   lifetimeElisionHints = {
        --     enable = "never",
        --     useParameterNames = false,
        --   },
        --   maxLength = 25,
        --   parameterHints = {
        --     enable = true,
        --   },
        --   reborrowHints = {
        --     enable = "never",
        --   },
        --   renderColons = true,
        --   typeHints = {
        --     enable = true,
        --     hideClosureInitialization = false,
        --     hideNamedConstructor = false,
        --   },
        --   locationLinks = false,
        -- },
        diagnostics = {
          enable = true,
          -- experimental = {
          --   enable = true,
          -- },
          disabled = {
            -- "macro-error",
            -- "unresolved-macro-call"
          }
        },
      }
    }
  },
  hls = {
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
  },
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
          ["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        },
      },
    },
  },
  terraformls = {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars" },
  },
  jdtls = {
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.level=ALL',
      '-noverify',
      '-Xmx1G',
      "-javaagent:" .. vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar",
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
      '-configuration', vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux/",
      '-data', vim.fn.stdpath("cache") .. '/jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'),
    },
    filetypes = { "java" },
    -- settings = {
    --   java = {
    --     format = {
    --       settings = {
    --         url = vim.fn.getcwd() .. "/eclipse-java-style.xml",
    --       }
    --     }
    --   }
    -- },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', 'mvnw', '.git', '.gitignore' }, { upward = true })[1]),
    on_init = function(client, _)
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
    on_attach = function()
      local jdtls_ok, jdtls = pcall(require, "jdtls")
      if jdtls_ok then
        jdtls.setup_dap({ hotcodereplace = 'auto' })
      end
    end,
    init_options = {
      bundles = {
        vim.fn.glob(
          vim.fn.stdpath("data") ..
          "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
      }
    }
  },
  lemminx = {
    cmd = { "lemminx" },
    filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
  },
  sqruff = {
    cmd = { "sqruff" },
    filetypes = { "sql" },
  },
  buf = {
    cmd = { "buf", "beta", "lsp", "--timeout=0", "--log-format=text" },
    filetypes = { "proto" },
  },
  tombi = {
    cmd = { "tombi", "lsp" },
    filetypes = { "toml" }
  },
}

servers_local = {
  -- don't forget to vim.lsp.enable("mals") when needed
  mals = {
    root_dir = vim.fn.getcwd(),
    cmd = {
      "/home/klephron/.local/share/mise/installs/go/1.25.4/bin/mals-adapter",
      -- "-l",
      -- vim.fn.getcwd() .. "/mals-adapter.log",
      "-t",
      "localhost:9651",
      "-g",
      "3",
    },
  }
}
return M
