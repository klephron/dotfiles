local utils = require("user.utils.plugins")
local block_reload = utils.block_reload
local fn = vim.fn
local api = vim.api
local fmt = string.format
---------------------------------------------------------------------------------------------------
-- PACKER
---------------------------------------------------------------------------------------------------
local install_path = fmt('%s/site/pack/packer/opt/packer.nvim', fn.stdpath('data'))
local packer_compiled_path = fmt('%s/packer/packer_compiled.lua', fn.stdpath('cache'))

local packer_bootstrap = utils.packer_bootstrap(install_path)

-- Impatient
safe_require("impatient")
--[[ local im_ok, impatient = safe_require("impatient")
if im_ok then impatient.enable_profile() end ]]

local packer = require("packer")

-- NOTE: packer cannot use local variables because they are upvalues
packer.startup({
  function(use)
    -- Utilities
    use { 'wbthomason/packer.nvim', opt = true }
    use { 'nvim-lua/plenary.nvim' } -- useful functions
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'milisims/nvim-luaref' }

    -- Caching
    use { "lewis6991/impatient.nvim" }

    -- Buffers
    use { "famiu/bufdelete.nvim" }


    -- Highlighting/colorschemes
    use { "EdenEast/nightfox.nvim", }

   use {
     "folke/todo-comments.nvim",
     config = plug_require("todo-comments")
   }
    use {
      'norcalli/nvim-colorizer.lua',
      config = plug_require("colorizer"),
    }
    use {
      'itchyny/vim-highlighturl',
      disable = true,
      config = function()
        -- vim.g.highlighturl_guifg = "#4d93ff"
      end
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = plug_require("treesitter"),
      disable = false,
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
      requires = {
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        { 'nvim-treesitter/playground' },
      }
    }

    -- UI
    use {
      "goolord/alpha-nvim",
      config = plug_require("alpha"),
    }
    use {
      'kyazdani42/nvim-tree.lua',
      config = plug_require("tree"),
    }
    use {
      'akinsho/bufferline.nvim',
      config = plug_require("bufferline"),
    }
    use {
      'nvim-lualine/lualine.nvim',
      config = plug_require("lualine"),
    }
    use {
      'rcarriga/nvim-notify',
      config = plug_require("notify"),
    }
    use {
      "folke/trouble.nvim",
      config = plug_require("trouble"),
    }
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = plug_require("indent-blankline"),
    }
    use {
      'j-hui/fidget.nvim',
      config = plug_require("fidget"),
      disable = true,
    }
    use {
      "akinsho/toggleterm.nvim",
      config = plug_require("toggleterm"),
    }
    use {
      'kevinhwang91/nvim-bqf',
      ft = "qf",
      config = plug_require("bqf"),
    }
    use {
      'stevearc/dressing.nvim',
      config = plug_require("dressing")
    }
    use {
      'ziontee113/color-picker.nvim',
      config = plug_require("colorpicker")
    }

    -- -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      config = plug_require("telescope"),
      requires = {
        {
          "ahmedkhalf/project.nvim",
          config = plug_require("project"),
        }
      },
    }

    -- -- Git
    use {
      'lewis6991/gitsigns.nvim',
      config = plug_require("gitsigns"),
    }
    use {
      'sindrets/diffview.nvim',
      module = 'diffview',
      cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
      config = plug_require("diffview").config,
      setup = plug_require("diffview").setup,
    }

    -- -- Installer for lsp, dap, linters, formatters
    use {
      "williamboman/mason.nvim",
      config = plug_require("mason"),
      requires = {
        "williamboman/mason-lspconfig.nvim",
      }
    }

    --LSP
    use { 'neovim/nvim-lspconfig',
      config = plug_require("lsp").setup,
      requires = {
        {
          'jose-elias-alvarez/null-ls.nvim',
        },
        {
          'ray-x/lsp_signature.nvim',
          config = plug_require("lsp.lsp_signature").setup,
        },
        {
          'stevearc/aerial.nvim',
          -- cmd = { "AerialToggle", "AerialToggle!" }, # used in lualine
          config = plug_require("lsp.aerial").setup,
        },
        {
          'kosayoda/nvim-lightbulb',
          disable = true,
          config = plug_require("lsp.lightbulb").setup,
        },
        {
          "glepnir/lspsaga.nvim",
          branch = "main",
          config = plug_require("lsp.lspsaga"),
        },
        {
          'folke/neodev.nvim',
          -- disable = true,
        },
      },
    }

    -- Debugging
    use {
      'mfussenegger/nvim-dap',
      setup = plug_require("dap").setup,
      config = plug_require("dap").config,
      requires = {
        {
          'rcarriga/nvim-dap-ui',
          conf = plug_require("dap.dapui")
        },
        {
          'theHamsta/nvim-dap-virtual-text',
          conf = plug_require("dap.virtual-text")
        },
        { 'nvim-telescope/telescope-dap.nvim' },
        -- languages
        { 'mfussenegger/nvim-dap-python' },
        { 'jbyuki/one-small-step-for-vimkind' },
      }
    }

    -- -- Snippet engine
    use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use
    use {
      "L3MON4D3/LuaSnip",
      config = plug_require("luasnip").config,
    }

    -- Cmp
    use {
      "hrsh7th/nvim-cmp", -- The completion plugin
      config = plug_require("cmp"),
      requires = {
        { "hrsh7th/cmp-buffer" }, -- buffer completions
        { "hrsh7th/cmp-path" }, -- path completions
        { "hrsh7th/cmp-cmdline" }, -- cmdline completions
        { "dmitmel/cmp-cmdline-history" }, -- cmdline history
        { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" }, -- nvim lua api
      }
    }

    -- Session
    -- select from {possession,auto-session}
    use {
      'jedrzejboczar/possession.nvim',
      config = plug_require("possession"),
      disable = true,
    }
    use {
      'rmagatti/auto-session',
      config = plug_require("auto-session"),
      disable = false,
      requires = {
        {
          'rmagatti/session-lens',
          config = plug_require("session-lens"),
        },
      }
    }

    -- Integrations
    use { -- Discord
      'andweeb/presence.nvim',
      config = plug_require("presence"),
    }
    use { -- for Firefox
      'glacambre/firenvim',
      run = function() vim.fn['firenvim#install'](0) end,
      config = function()
      end
    }

    -- Editing
    use {
      'windwp/nvim-autopairs',
      disable = false,
      config = plug_require("autopairs"),
    }
    use {
      "numToStr/Comment.nvim",
      config = plug_require("comment"),
    }
    use {
      'folke/which-key.nvim',
      config = plug_require("which-key")
    }
    use {
      'phaazon/hop.nvim',
      keys = {
        { "n", "s" }, { "x", "s" }, { "o", "s" },
        { "n", "f" }, { "x", "f" }, { "o", "f" },
        { "n", "F" }, { "x", "F" }, { "o", "F" },
        { "n", "t" }, { "x", "t" }, { "o", "t" },
        { "n", "T" }, { "x", "T" }, { "o", "T" },
      },
      config = plug_require("hop")
    }
    use {
      'mfussenegger/nvim-treehopper',
      config = function()
        us.set_keyremap("o", "m", ":<c-u>lua require('tsht').nodes()<cr>")
        us.set_keynomap("x", "m", ":lua require('tsht').nodes()<cr>")
      end
    }
    use {
      "kylechui/nvim-surround",
      tag = "*",
      config = plug_require("surround"),
    }
    use { 'anuvyklack/hydra.nvim' } -- wonderful plugin for submodes
    use {
      'mg979/vim-visual-multi',
      config = function()
        vim.g.VM_highlight_matches = ""
        -- vim.g.VM_maps = {
        --
        -- }
      end
    }


    -- Task management, notes
    use {
      'lukas-reineke/headlines.nvim',
      ft = { "markdown", "org", "norg" },
      disable = true, -- bad performance on big files
      config = plug_require("headlines"),
    }
    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = "markdown",
      config = [[
        vim.g.mkdp_theme = 'dark'
      ]],
    }
    use {
      'nvim-neorg/neorg',
      config = plug_require("neorg").config,
      setup = plug_require("neorg").setup,
      cmd = { "NeorgStart" },
      module = "neorg",
      -- tag = '0.0.12',
      requires = {
        'vhyrro/neorg-telescope',
        'max397574/neorg-kanban',
      },
    }
    use {
      'lervag/vimtex',
      ft = "tex",
      config = [[
        vim.g.tex_flavor='latex'
        vim.g.vimtex_view_method='zathura'
        vim.g.vimtex_indent_on_ampersands=0
        vim.g.vimtex_quickfix_mode=0
        vim.g.vimtex_compiler_latexmk = {
          build_dir = 'build',
          options = {
            '-shell-escape'
          }
        }
        vim.cmd("hi clear Conceal")
      ]]
    }
  end,
  log = { level = 'info' },
  config = {
    max_jobs = 50,
    compile_path = packer_compiled_path,
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
    git = {
      clone_timeout = 240,
    },
    profile = {
      enable = false,
      threshold = 1,
    },
  }
})

-- Automatically set up your configuration after cloning packer.nvim
if packer_bootstrap then
  packer.sync()
end


if not vim.g.packer_compiled_loaded and vim.loop.fs_stat(packer_compiled_path) then
  vim.cmd(fmt('source %s', packer_compiled_path))
  vim.g.packer_compiled_loaded = true
end

-- Reload plugins when plugins/*.lua is saved
api.nvim_create_user_command("LocalPackerCompile", function()
  us.reload("user.plugins", true)
  packer.compile()
  utils.packer_notify("Compiled", vim.log.levels.INFO)
end, { nargs = 0 })

-- us.augroup("PackerSetupInit", {
--   {
--     event = "BufWritePost",
--     pattern = { "*/user.plugins/*.lua" },
--     description = "Packer reload",
--     command = "LocalPackerCompile",
--   }
-- })
