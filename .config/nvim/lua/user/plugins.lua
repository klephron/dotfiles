local fn = vim.fn

-- automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
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
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]


local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float({border = "single"})
    end,
  },
}

return packer.startup(function()
  use {'wbthomason/packer.nvim'}
  use {'nvim-lua/plenary.nvim'} -- useful functions
  use {'kyazdani42/nvim-web-devicons'}

  -- Colorschemes
  use {"lunarvim/darkplus.nvim"}
  -- UI
  use {"goolord/alpha-nvim"}
  use {'kyazdani42/nvim-tree.lua' }
  use {'norcalli/nvim-colorizer.lua'}

  --LSP
  use {'neovim/nvim-lspconfig'}
  use {'williamboman/nvim-lsp-installer'}

  -- Snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  use "L3MON4D3/LuaSnip" --snippet engine

  -- Cmp 
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- Treesitter
  use {
       'nvim-treesitter/nvim-treesitter',
       run = ':TSUpdate'
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }


  -- Markdown/Latex
  use {
    'lervag/vimtex',
    ft = "tex",
    config =  [[
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
  if packer_bootstrap then
    packer.sync()
  end
end)

