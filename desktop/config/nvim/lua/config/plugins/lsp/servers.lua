local M = {
  lua_ls = {
    -- cmd = { "/home/folke/projects/lua-language-server/bin/lua-language-server" },
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
      },
    },
  },
  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  },
  pyright = {
    single_file_support = true
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cachePriming = {
          enable = false
        },
        assist = {
          importEnforceGranularity = true,
          importPrefix = 'crate',
        },
        -- cargo = {
        --   features = "all",
        --   sysrootQueryMetadata = true,
        -- },
        checkOnSave = {
          command = 'clippy',
        },
        inlayHints = { locationLinks = false },
        diagnostics = {
          enable = false,
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
  tsserver = {},
  cssls = {},
  cssmodules_ls = {},
  css_variables = {},
  bashls = {},
}

return M
