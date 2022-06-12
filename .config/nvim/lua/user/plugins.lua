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

-- install plugins
return packer.startup(function()
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use "goolord/alpha-nvim"

  use { 'kyazdani42/nvim-tree.lua' }

  use {
       'nvim-treesitter/nvim-treesitter',
       run = ':TSUpdate'
  }

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- sync configuration after cloning packer.nvim
  if packer_bootstrap then
    packer.sync()
  end
end)

