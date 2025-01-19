local M = {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls = require("jdtls")
      local funcs = require("utils.funcs")

      local resolve_ops = function()
        local options = require("config.plugins.lspconfig").fetch_options()

        local opts = {}

        -- jdtls
        local jdtls_install_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"
        local jdtls_jar_path = vim.fn.glob(jdtls_install_path .. 'plugins/' .. 'org.eclipse.equinox.launcher_*.jar')

        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        local workspace_dir = vim.fn.stdpath("cache") .. '/jdtls/workspace/' .. project_name

        local config_type = jdtls_install_path .. "config_linux/"

        -- java-debug-adapter
        local jda_install_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/"
        local jda_jar_path = vim.fn.glob(jda_install_path .. "extension/server/com.microsoft.java.debug.plugin-*.jar", 1)

        opts = {
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
            '-jar', jdtls_jar_path,
            '-configuration', config_type,
            '-data', workspace_dir,
          },

          on_attach = function(client, bufnr)
            options.on_attach(client, bufnr)
            -- NOTE: when launching dap update config:
            -- require('jdtls.dap').setup_dap_main_class_configs()
            jdtls.setup_dap({ hotcodereplace = 'auto' })
          end,

          init_options = {
            bundles = {
              jda_jar_path
            },
          },
          root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', 'mvnw', '.git', '.gitignore' }, { upward = true })[1]),
          on_init = function(client)
            -- Disable semantic tokens to prevent syntax highlighting changes
            client.server_capabilities.semanticTokensProvider = nil
          end
        }

        return vim.tbl_deep_extend("force", {}, options, opts or {})
      end

      funcs.augroup("local_jdtls_start", {
        {
          event = "FileType",
          pattern = { "java" },
          command = function()
            local opts = resolve_ops()
            require("jdtls").start_or_attach(opts)
          end
        }
      })
    end
  }
}

return M
