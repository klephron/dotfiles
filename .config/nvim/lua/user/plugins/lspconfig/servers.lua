local M = {
  sumneko_lua = {
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
      standalone = true,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          features = "all",
        },
      }
    }
  },
}

return M
