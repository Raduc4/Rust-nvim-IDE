-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'airblade/vim-gitgutter'
  use 'rust-lang/rust.vim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use "savq/melange"
  use {
      'ojroques/nvim-lspfuzzy',
    requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},  -- to enable preview (optional)
    }
    ,
  }
  use { "alexghergh/nvim-tmux-navigation" }
  use {
    'kyazdani42/nvim-tree.lua',
       requires = {
         'kyazdani42/nvim-web-devicons', -- optional, for file icons
       },
     tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use {
  "startup-nvim/startup.nvim",
  requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
  config = function()
    require"startup".setup()
  end
  }
  use "Pocco81/AutoSave.nvim"
  use 'folke/tokyonight.nvim'
end)

