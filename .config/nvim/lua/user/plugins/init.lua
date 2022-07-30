local utils = require("user.utils.plugins")
local conf = utils.conf
local block_reload = utils.block_reload
local fn = vim.fn
local fmt = string.format

-- Stop loading built in plugins
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1

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

    -- NOTE: remove when https://github.com/neovim/neovim/issues/12587 will be resolved
    use {
      'antoinemadec/FixCursorHold.nvim',
      config = function()
        vim.cmd [[
          " let g:cursorhold_updatetime = 100
        ]]
      end
    }

    -- Utilities
    use { 'wbthomason/packer.nvim' , opt = true }
    use { 'nvim-lua/plenary.nvim' } -- useful functions
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'milisims/nvim-luaref' }

    -- Caching
    use { "lewis6991/impatient.nvim"}

    -- Editing
    use {
      'windwp/nvim-autopairs',
      disable = false,
      config = conf("autopairs"),
    }
    use {
      "numToStr/Comment.nvim",
      config = conf("comment"),
    }
    use {
      'folke/which-key.nvim',
      config = conf("which-key")
    }
    use {
      'phaazon/hop.nvim',
      config = conf("hop")
    }
    use {
      'mfussenegger/nvim-treehopper',
      config = function()
        us.set_keyremap("o", "m", ":<c-u>lua require('tsht').nodes()<cr>")
        us.set_keynomap("x", "m", ":lua require('tsht').nodes()<cr>")
      end
    }

    -- Highlighting/colorschemes
    use { "lunarvim/darkplus.nvim" }
    use {
      "folke/todo-comments.nvim",
      config = block_reload(conf("todo-comments"))
    }
    use {
      'norcalli/nvim-colorizer.lua',
      config = conf("colorizer"),
    }
    use {
      'itchyny/vim-highlighturl',
      disable = true,
      config = function()
        -- vim.g.highlighturl_guifg = "#4d93ff"
      end
    }

    -- UI
    use {
      "goolord/alpha-nvim",
      config = conf("alpha"),
    }
    use {
      'kyazdani42/nvim-tree.lua',
      config = conf("tree"),
    }
    use {
      'akinsho/bufferline.nvim',
      config = conf("bufferline"),
    }
    use {
      'nvim-lualine/lualine.nvim',
      config = conf("lualine"),
    }
    use { -- cmdheight = 2 is bad
      'rcarriga/nvim-notify',
      config = conf("notify"),
    }
    use {
      "folke/trouble.nvim",
      config = conf("trouble"),
    }
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = conf("indent-blankline"),
    }
    use {
      'j-hui/fidget.nvim',
      config = conf("fidget"),
    }
    use {
      "akinsho/toggleterm.nvim",
      config = conf("toggleterm"),
    }

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      config = conf("gitsigns"),
    }
    use { --WARN: not configured
      'sindrets/diffview.nvim',
      -- module = 
      cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
      config = conf("diffview")
    }

    --LSP
    use { 'neovim/nvim-lspconfig',
      config = conf("lsp"),
      requires = {
        { 'williamboman/nvim-lsp-installer' },
        { 'jose-elias-alvarez/null-ls.nvim' },
        { 'folke/lua-dev.nvim' },
        { 'ray-x/lsp_signature.nvim' },
      },
    }

    -- Snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
    use "L3MON4D3/LuaSnip" --snippet engine

    -- Cmp
    use {
      "hrsh7th/nvim-cmp", -- The completion plugin
      config = conf("cmp"),
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

    -- Debugging
    use {
      'mfussenegger/nvim-dap',
      setup = conf("dap").setup,
      config = conf("dap").config,
      requires = {
      }
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = conf("treesitter"),
      run = ':TSUpdate',
      requires = {
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        { 'nvim-treesitter/playground' },
      }
    }

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      config = conf("telescope"),
      requires = {
        {
          "ahmedkhalf/project.nvim",
          config = conf("project"),
        }
      },
    }

    -- Task management, notes
    use {
      'lukas-reineke/headlines.nvim',
      config = conf("headlines"),
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
      -- ft = "norg",
      config = conf("neorg"),
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


-- TODO: add plugins in black list if they can't be reloaded after config change (ex. nvim-notify)

if not vim.g.packer_compiled_loaded and vim.loop.fs_stat(packer_compiled_path) then
  vim.cmd(fmt('source %s', packer_compiled_path))
  vim.g.packer_compiled_loaded = true
end

-- reload neovim when file plugins.lua is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */user/plugins/*.lua source <afile> | PackerCompile
  augroup end
]]
