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
  ruff = {
    settings = {
    }
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
  gopls = {},
  hls = {
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
  },
  -- denols = {},
  ts_ls = {},
  cssls = {},
  cssmodules_ls = {},
  css_variables = {},
  bashls = {},
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
  ansiblels = {},
  lemminx = {},
  terraformls = {
    filetypes = { "terraform", "terraform-vars" }
  },
}

return M
