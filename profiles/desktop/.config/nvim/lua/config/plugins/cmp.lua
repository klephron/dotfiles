local M = {
  "hrsh7th/nvim-cmp",
  -- event = "InsertEnter",
  event = "VeryLazy",
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")
    local lspkind = require('lspkind')
    local protocol = require("vim.lsp.protocol")

    -- Function implementations
    local function has_words_before()
      local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local function cmp_complete_toggle()
      if not cmp.visible() then
        cmp.complete()
      else
        cmp.abort()
      end
    end

    local function cmp_open_menu(fallback)
      if not cmp.visible() then
        cmp.complete()
      end
    end

    local function cmp_select_next(fallback)
      cmp_open_menu(fallback)
      cmp.select_next_item()
    end

    local function cmp_select_prev(fallback)
      cmp_open_menu(fallback)
      cmp.select_prev_item()
    end

    local function cmp_complete_intellij(fallback)
      if cmp.visible() then
        local entries = cmp.get_entries()
        if #entries > 0 then
          local first = entries[1]
          local first_is_exact = first.exact
          local first_item = first.completion_item
          local first_kind = first_item.kind
          local is_expand_or_jump = luasnip.expand_or_jumpable()

          cmp.confirm({
            select = true
          }, function()
            if first_is_exact and
                is_expand_or_jump and
                first_kind ~= protocol.CompletionItemKind.Snippet
            then
              luasnip.expand_or_jump()
            end
          end)
        else
          fallback()
        end
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif not has_words_before() then
        fallback()
      else
        cmp_open_menu(fallback)
      end
    end

    cmp.config.disable = true -- disable default mappings
    cmp.setup({
      enabled = function()
        return not vim.tbl_contains({ "TelescopePrompt" }, vim.bo.filetype)
      end,
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      mapping = {
        ["<Tab>"] = cmp.mapping(cmp_complete_intellij, { "i", "s" }),
        ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "s" }),
        ["<M-Space>"] = cmp.mapping(cmp.mapping.confirm { select = true }, { "i", "s" }),

        ["<C-n>"] = cmp.mapping(cmp_select_next, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(cmp_select_prev, { "i", "s" }),

        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "s" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "s" }),

        ["<C-l>"] = cmp.mapping(cmp_complete_toggle, { "i" }),
        ["<M-l>"] = cmp.mapping(cmp_complete_toggle, { "i" }),

        ["<C-q>"] = cmp.mapping { i = cmp.mapping.abort() },
        ["<M-q>"] = cmp.mapping { i = cmp.mapping.abort() },
      },
      completion = {},
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      preselect = cmp.PreselectMode.None,
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = {
            abbr = function() return math.floor(0.25 * vim.o.columns) end,
            menu = function() return math.floor(0.30 * vim.o.columns) end,
          },
          ellipsis_char = '…',
          show_labelDetails = true,
          before = function(entry, vim_item)
            return vim_item
          end
        })
      },
      duplicates = {
        nvim_lsp = 1,
        luasnip = 1,
        cmp_tabnine = 1,
        buffer = 1,
        path = 1,
      },
      sources = {
        { name = "copilot",  priority = 1250, group_index = 2 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
      },
      experimental = {
        ghost_text = false
      }
    })
  end
}

return M
