return function()
  local cmp = require("cmp")

  local luasnip_status_ok, luasnip = safe_require("luasnip")
  if not luasnip_status_ok then
    return
  end

  require("luasnip.loaders.from_vscode").lazy_load()

  local kind_icons = require("user.icons").kind_icons
  ----------------------------------------------------------------------------------------------------
  -- CMP.SETUP
  ----------------------------------------------------------------------------------------------------
  local function tab(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end
  end

  local function s_tab(fallback)
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

  cmp.setup {
    enabled = function()
      return not vim.tbl_contains({ "TelescopePrompt" }, vim.bo.filetype)
    end,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(tab, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(s_tab, { "i", "s" }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-p>"] = cmp.mapping.select_prev_item(),

      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

      ["<M-Space>"] = cmp.mapping.confirm { select = true },
      ["<C-l>"] = cmp.mapping(toggle_complete, { "i", "c" }),

      ["<C-q>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<A-q>"] = cmp.mapping(cmp.mapping.abort(), {"i"}),
    },
    completion = {},
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = 'nvim_lua' },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = false,
    }
  }

  local cmdline_override = {}
  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    completion = { autocomplete = false, },
    mapping = cmp.mapping.preset.cmdline(cmdline_override),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    --completion = { autocomplete = true, },
    mapping = cmp.mapping.preset.cmdline(cmdline_override),
    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lua = "[LUA]",
          path = "[Path]",
          cmdline_history = "[Hist]",
          cmdline = "[CMD]",
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'nvim_lua' },
      { name = 'cmdline' },
      -- { name = 'cmdline_history' },
    })
  })

end
