return function()
  local configs = require("nvim-treesitter.configs")

  configs.setup {
    ensure_installed = "all",
    -- ensure_installed = { "cpp", "c", "java", "bash", "clojure", "vim", "lua", "norg" },
    sync_install = false,
    ignore_install = { "markdown", "latex", "bibtex" },
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
      disable = { "markdown", "latex", "bibtex" },
      additional_vim_regex_highlighting = false,
    },
    autopairs = { enable = true },
    indent = { enable = true },
    incremental_selection = {},
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    }
  }
end
