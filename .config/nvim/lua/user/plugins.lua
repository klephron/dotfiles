return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- NvimTree
  use { 'kyazdani42/nvim-tree.lua' }

  -- TreeSitter
  use {
       'nvim-treesitter/nvim-treesitter',
       run = ':TSUpdate'
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
end)

