local options = nil

local servers_options = {
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
      redhat = {
        telemetry = {
          enabled = false,
        },
      },
      yaml = {
        format = {
          enable = false,
        },
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
local function options_get()
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
local function options_fetch()
  if options == nil then
    options = options_get()
  end
  return options
end

local function diagnostics_configure()
  local diagnostics_icons = require("icons").diagnostics
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

local function keymaps_on_attach(client, bufnr)
  local utils = require("utils")

  local lspsaga_ok = false

  local function wrap(desc)
    return { buffer = bufnr, desc = desc, nowait = true }
  end

  -- definitionProvider
  utils.set_keynomap("n", "<leader>kd", vim.lsp.buf.definition, wrap("[lsp] Goto definition"))
  utils.set_keynomap("n", "gd", vim.lsp.buf.definition, wrap("[lsp] Goto definition"))

  -- declarationProvider
  utils.set_keynomap("n", "<leader>kf", vim.lsp.buf.declaration, wrap("[lsp] Goto declaration"))
  utils.set_keynomap("n", "gf", vim.lsp.buf.declaration, wrap("[lsp] Goto declaration"))

  -- hoverProvider
  utils.set_keynomap("n", "<leader>kl", function() vim.lsp.buf.hover({ border = "single", width = 80 }) end,
    wrap("[lsp] Hover"))
  utils.set_keynomap("n", "gl", function() vim.lsp.buf.hover({ border = "single", width = 80 }) end,
    wrap("[lsp] Hover"))

  -- implementationProvider
  utils.set_keynomap("n", "<leader>ki", vim.lsp.buf.implementation, wrap("[lsp] Goto implementation"))
  utils.set_keynomap("n", "gm", vim.lsp.buf.implementation, wrap("[lsp] Goto implementation"))

  -- renameProvider
  utils.set_keynomap("n", "<leader>kn", vim.lsp.buf.rename, wrap("[lsp] Rename"))

  -- referencesProvider
  utils.set_keynomap("n", "<leader>kr", vim.lsp.buf.references, wrap("[lsp] List references"))
  utils.set_keynomap("n", "gr", vim.lsp.buf.references, wrap("[lsp] List references"))

  -- codeActionProvider
  if lspsaga_ok then
    utils.set_keynomap("n", "<leader>ka", "<cmd>Lspsaga code_action<cr>", wrap("[lspsaga] Open code action"))
  else
    utils.set_keynomap("n", "<leader>ka", vim.lsp.buf.code_action, wrap("[lsp] Open code action"))
  end

  -- signatureHelpProvider
  utils.set_keynomap("n", "<leader>kk",
    function() vim.lsp.buf.signature_help({ border = "single", width = 80 }) end,
    wrap("[lsp] Open signature help"))

  -- typeDefinitionProvider
  utils.set_keynomap("n", "<leader>kp", vim.lsp.buf.type_definition, wrap("[lsp] Goto type definition"))
  utils.set_keynomap("n", "gp", vim.lsp.buf.type_definition, wrap("[lsp] Goto type definition"))

  -- codeLensProvider
  utils.set_keynomap("n", "<leader>kc", vim.lsp.codelens.run, wrap("[lsp] Run codelens"))

  -- documentSymbolProvider

  -- documentFormattingProvider
  --[[ -- handled by conform-nvim
  funcs.set_keynomap("n", kmps.format.key, function() vim.lsp.buf.format({ async = true }) end,
  with_desc(("format"))) ]]

  -- selectionRangeProvider
  utils.set_keynomap('x', 'an', function() vim.lsp.buf.selection_range('outer') end,
    wrap("[lsp] Outer selection_range"))
  utils.set_keynomap('x', 'in', function() vim.lsp.buf.selection_range('inner') end,
    wrap("[lsp] Inner selection_range"))

  -- Diagnostics
  utils.set_keynomap("n", "<leader>kh", vim.diagnostic.open_float, wrap("[diagnostic] Open float"))
  utils.set_keynomap("n", "gh", vim.diagnostic.open_float, wrap("[diagnostic] Open float"))
  utils.set_keynomap("n", "[d", vim.diagnostic.goto_prev, wrap("[diagnostic] Goto previous"))
  utils.set_keynomap("n", "]d", vim.diagnostic.goto_next, wrap("[diagnostic] Goto next"))

  -- inlayHint
  utils.set_keynomap("n", "<localleader>kh",
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      vim.notify("[lsp] inlay hints " ..
        (vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"), vim.log.levels.INFO, { title = "lsp" })
    end,
    "[lsp] Toggle inlay hints")
end

local function on_attach(client, bufnr)
  keymaps_on_attach(client, bufnr)
end

local function _servers_configure(servers)
  local options = options_fetch()

  -- default
  vim.lsp.config("*", vim.tbl_deep_extend("force", {}, options, { on_attach = on_attach }))

  -- specific server configurations
  for server, server_options in pairs(servers) do
    server_options = vim.tbl_deep_extend("force", {}, options, server_options or {})

    local server_on_attach = server_options.on_attach

    if server_on_attach then
      server_options.on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        server_on_attach(client, bufnr)
      end
    else
      server_options.on_attach = on_attach
    end

    vim.lsp.config(server, server_options)
  end
end

local function servers_configure()
  return _servers_configure(servers_options)
end

local function _servers_enable(servers)
  for server, _ in pairs(servers) do
    vim.lsp.enable(server, true)
  end
end

local function servers_enable()
  return _servers_enable(servers_options)
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
  },
  config = function()
    local utils = require("utils")

    diagnostics_configure()

    utils.set_keynomap("n", "<localleader>kd", "<cmd>lsp disable<cr>", "[lsp] Disable LSP")
    utils.set_keynomap("n", "<localleader>ke", "<cmd>lsp enable<cr>", "[lsp] Enable LSP")
    utils.set_keynomap("n", "<localleader>ki", "<cmd>LspInstall<cr>", "[lspconfig] Install LSP for ft using mason")
    utils.set_keynomap("n", "<localleader>kr", "<cmd>lsp restart<cr>", "[lsp] Restart LSP")
    utils.set_keynomap("n", "<localleader>ks", "<cmd>checkhealth lsp<cr>", "[nvim] Checkhealth LSP")
    utils.set_keynomap("n", "<localleader>kt", "<cmd>lsp stop<cr>", "[lsp] Stop LSP")
  end,
  options_fetch = options_fetch,
  on_attach = on_attach,
  servers_configure = servers_configure,
  servers_enable = servers_enable,
  servers_options = servers_options,
}
