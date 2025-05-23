-- :h lspconfig-all
local M = {
  lua_ls = {
    single_file_support = true,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            continuation_indent_size = "2",
          },
        },
        hint = {
          enable = true,
        }
      },
    },
  },
  clangd = {
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
    single_file_support = true
  },
  rust_analyzer = {
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
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
  },
  yamlls = {
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
    filetypes = { "terraform", "terraform-vars" }
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
    -- settings = {
    --   java = {
    --     format = {
    --       settings = {
    --         url = vim.fn.getcwd() .. "/eclipse-java-style.xml",
    --       }
    --     }
    --   }
    -- },
    on_init = function(client, _)
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
  lemminx = {}
}

return M
