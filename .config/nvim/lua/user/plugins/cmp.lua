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
  local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local function tab(fallback)
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
    -- preselect = cmp.PreselectMode.Item,
    mapping = {
      ["<Tab>"] = cmp.mapping(tab, { "i" }), -- if using 'c' then it will be triggered on cmdline
      ["<S-Tab>"] = cmp.mapping(s_tab, { "i" }),

      ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "s" }),
      ["<M-Space>"] = cmp.mapping(cmp.mapping.confirm { select = true }, { "i", "s" }),

      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i" }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i" }),

      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "s" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "s" }),


      ["<C-l>"] = cmp.mapping(toggle_complete, { "i" }),
      ["<A-l>"] = cmp.mapping(toggle_complete, { "i" }),

      ["<C-q>"] = cmp.mapping { i = cmp.mapping.abort(), },
      ["<A-q>"] = cmp.mapping { i = cmp.mapping.abort(), },
    },
    completion = {},
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
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

  local function cmdline_tab()
    if not cmp.visible() then
      cmp.complete()
    end
    cmp.select_next_item()
  end

  local function cmdline_s_tab()
    if not cmp.visible() then
      cmp.complete()
    end
    cmp.select_prev_item()
  end

  local function cmdline_cr(fallback)
    if cmp.visible() then
      cmp.confirm({ select = true })
    end
    fallback()
  end

  cmp.setup.cmdline(':', {
    --[[ mapping = cmp.mapping.preset.cmdline({}), ]]
    mapping = {
      ["<Tab>"] = cmp.mapping({ c = cmdline_tab }),
      ["<S-Tab>"] = cmp.mapping({ c = cmdline_s_tab }),
      --[[ ['<CR>'] = cmp.mapping({ c = cmdline_cr }), ]]

      ["<C-n>"] = cmp.mapping({ c = cmp.mapping.select_next_item() }),
      ["<C-p>"] = cmp.mapping({ c = cmp.mapping.select_prev_item() }),

      ["<M-Space>"] = cmp.mapping({ c = cmp.mapping.confirm { select = true } }),

      ["<C-l>"] = cmp.mapping({ c = toggle_complete }),
      ["<A-l>"] = cmp.mapping({ c = toggle_complete }),

      ["<C-q>"] = cmp.mapping { c = cmp.mapping.abort(), },
      ["<A-q>"] = cmp.mapping { c = cmp.mapping.abort(), },
    },
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
    }),
  })

  cmp.setup.cmdline('@', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({}),
  })
end
