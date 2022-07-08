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
  use {'wbthomason/packer.nvim'}
  use {'kyazdani42/nvim-web-devicons'}
  use {"goolord/alpha-nvim"}

  use { 'kyazdani42/nvim-tree.lua' }

  use {
       'nvim-treesitter/nvim-treesitter',
       run = ':TSUpdate'
  }

  --LSP
  use {'neovim/nvim-lspconfig'}
  use {'williamboman/nvim-lsp-installer'}

  --Latex
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
    ]]
  }
  use { 
    'KeitaNakamura/tex-conceal.vim',
    requires = { 'lervag/vimtex' },
    config = [[
      vim.g.tex_conceal='abdmg'
      vim.opt.conceallevel=2
    ]],
  }
    
  use { --currently used only for LaTeX
    'sirver/ultisnips',
    ft = "tex",
    config = [[
      vim.g.UltiSnipsExpandTrigger = '<Tab>'
      vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
      vim.g.UltiSnipsSnippetDirectories= {'ultisnippets'}
    ]],
  }
 use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = [[
      vim.g.mkdp_theme = 'dark'
    ]],
  }

  -- sync configuration after cloning packer.nvim
  if packer_bootstrap then
    packer.sync()
  end
end)

