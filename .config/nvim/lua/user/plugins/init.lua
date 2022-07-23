local utils = require("user.utils.plugins")
local fn = vim.fn
local conf = utils.conf

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
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- automatically install packer
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  }
end

-- reload neovim when file plugins.lua is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */user/plugins/*.lua source <afile> | PackerCompile
  augroup end
]]

local status_ok, packer = safe_require("packer")
if not status_ok then
  return
end

-- Impatient
safe_require("impatient")
--[[ local im_ok, impatient = safe_require("impatient")
if im_ok then impatient.enable_profile() end ]]

-- NOTE: packer cannot use local variables because they are upvalues
-- TODO: check if packer is loaded then don't update these plugins until
-- restart
packer.startup({
  function(use)

    -- Utilities
    use { 'wbthomason/packer.nvim' }
    use { 'nvim-lua/plenary.nvim' } -- useful functions
    use { 'kyazdani42/nvim-web-devicons' }

    -- Load using cache
    use { "lewis6991/impatient.nvim" }

    use {
      'windwp/nvim-autopairs',
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
    use { 'milisims/nvim-luaref' }

    -- Colorschemes
    use { "lunarvim/darkplus.nvim" }

    -- UI
    use {
      "goolord/alpha-nvim",
      config = conf("alpha"),
    }
    use {
      'kyazdani42/nvim-tree.lua',
      config = conf("nvim-tree"),
    }
    use {
      'norcalli/nvim-colorizer.lua',
      config = conf("colorizer"),
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
      config = conf("nvim-notify"),
    }
    use {
      "folke/trouble.nvim",
      config = conf("trouble"),
    }
    use {
      'lewis6991/gitsigns.nvim',
      config = conf("gitsigns"),
    }
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = conf("indent-blankline"),
    }

    --LSP
    use { 'neovim/nvim-lspconfig',
      config = conf("lsp"),
      requires = {
        { 'williamboman/nvim-lsp-installer' },
        { 'jose-elias-alvarez/null-ls.nvim' },
        { 'folke/lua-dev.nvim' },
        { 'ray-x/lsp_signature.nvim'},
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
      'nvim-neorg/neorg',
      -- ft = "norg",
      config = conf("neorg"),
    }

    use {
      'lukas-reineke/headlines.nvim',
      config = conf("headlines"),
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
    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      cmd = "MarkdownPreview",
      config = [[
        vim.g.mkdp_theme = 'dark'
      ]],
    }

    -- sync configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
      packer.sync()
    end

  end,
  log = { level = 'info' },
  config = {
    max_jobs = 50,
    compile_path = vim.fn.stdpath('data') .. '/site/pack/loader/start/packer.nvim/plugin/packer_compiled.lua',
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
