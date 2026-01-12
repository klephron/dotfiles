-- :h lspconfig-all
local M = {
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
}

return M
