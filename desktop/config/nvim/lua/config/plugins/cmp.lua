local M = {
  "hrsh7th/nvim-cmp",
  -- event = "InsertEnter",
  event = "VeryLazy",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")
    local kind_icons = require("config.icons").kind_icons

    -- Function implementations
    local function has_words_before()
      local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local function tab_select(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end

    local function s_tab_select(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end

    local function toggle_complete()
      if not cmp.visible() then
        cmp.complete()
      else
        cmp.abort()
      end
    end

    local function open_cmp_menu(fallback)
      if not cmp.visible() then
        cmp.complete()
      end
    end

    local function select_next_item(fallback)
      open_cmp_menu(fallback)
      cmp.select_next_item()
    end

    local function select_prev_item(fallback)
      open_cmp_menu(fallback)
      cmp.select_prev_item()
    end

    local function tab_intellij(fallback)
      -- file = io.open("~/tmp/lua.log", "w")
      -- io.output(file)
      -- io.write(vim.inspect(cmp.get_entries()[1].completion_item))
      -- file:close()
      if cmp.visible() then
        local is_exact = cmp.get_entries()[1].exact
        local comp_item = cmp.get_entries()[1].completion_item
        -- if is not expanded
        local is_simple = comp_item.filterText == comp_item.insertText
            or comp_item.insertTextFormat == nil;
        cmp.confirm({
          select = true
        }, function() -- callback
          if is_exact and is_simple and luasnip.jumpable(1) then
            luasnip.expand_or_jump()
          end
        end)
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif not has_words_before() then
        fallback()
      else
        open_cmp_menu(fallback)
      end
    end

    -- Mappings
    local old_mappings = {
      ["<Tab>"] = cmp.mapping(tab_select, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(s_tab_select, { "i", "s" }),

      ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "s" }),
      ["<M-Space>"] = cmp.mapping(cmp.mapping.confirm { select = true }, { "i", "s" }),

      ["<C-n>"] = cmp.mapping(select_next_item, { "i", "s" }),
      ["<C-p>"] = cmp.mapping(select_prev_item, { "i", "s" }),

      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "s" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "s" }),

      ["<C-l>"] = cmp.mapping(toggle_complete, { "i" }),
      ["<M-l>"] = cmp.mapping(toggle_complete, { "i" }),

      ["<C-q>"] = cmp.mapping { i = cmp.mapping.abort() },
      ["<M-q>"] = cmp.mapping { i = cmp.mapping.abort() },
    }

    local intellij_mappings = {
      ["<Tab>"] = cmp.mapping(tab_intellij, { "i", "s" }),
      ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "s" }),
      ["<M-Space>"] = cmp.mapping(cmp.mapping.confirm { select = true }, { "i", "s" }),

      ["<C-n>"] = cmp.mapping(select_next_item, { "i", "s" }),
      ["<C-p>"] = cmp.mapping(select_prev_item, { "i", "s" }),

      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "s" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "s" }),

      ["<C-l>"] = cmp.mapping(toggle_complete, { "i" }),
      ["<M-l>"] = cmp.mapping(toggle_complete, { "i" }),

      ["<C-q>"] = cmp.mapping { i = cmp.mapping.abort() },
      ["<M-q>"] = cmp.mapping { i = cmp.mapping.abort() },
    }

    cmp.config.disable = true -- disable default mappings
    cmp.setup {
      enabled = function()
        return not vim.tbl_contains({ "TelescopePrompt" }, vim.bo.filetype)
      end,
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      mapping = intellij_mappings,
      completion = {},
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      preselect = cmp.PreselectMode.None,
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            luasnip = "[S]",
            buffer = "[B]",
            path = "[P]",
          })[entry.source.name]
          return vim_item
        end,
      },
      duplicates = {
        nvim_lsp = 1,
        luasnip = 1,
        cmp_tabnine = 1,
        buffer = 1,
        path = 1,
      },
      sources = {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
      },
    }
  end
}

return M
