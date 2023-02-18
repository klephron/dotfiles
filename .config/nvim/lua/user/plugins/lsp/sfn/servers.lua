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
    standalone = false,
    settings = {
      ["rust-analyzer"] = {
        -- assist = {
        --   importEnforceGranularity = true,
        --   importPrefix = 'crate',
        -- },
        cargo = {
          features = "all",
        },
        checkOnSave = {
          command = 'clippy',
        },
        -- inlayHints = { locationLinks = false },
        diagnostics = {
          enable = true,
          experimental = {
            enable = true,
          },
        },
      }
    }
  },
  gopls = {},
}

return M
