local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim"    -- Have packer manage itself
  use "nvim-lua/popup.nvim"       -- An implementation of the Popup API from vim in Neovim
  use 'mhinz/vim-startify'        -- This plugin provides a start screen for Vim and Neovim.
  use 'Yggdroot/indentLine'       -- Display Indentation line
  use 'danro/rename.vim'          -- Easialy rename files using :Rename filename newfilename
  use 'janko-m/vim-test'          -- Run tests from vim.
  use 'tpope/vim-surround'        -- Easily replace commas, quotes, parentheses or edit words surround by it.
  use 'kyazdani42/nvim-tree.lua'  -- File tree
  use 'tpope/vim-commentary'      -- Add shortcuts for commenting block of codes.
  use 'bogado/file-line'          -- Plugin to enable vim to open the file in the spefic line ex. app/models/user.rb:1337
  use 'benmills/vimux'            -- Creates or run commands from VIM on existing TMUX panes.
  use 'hauleth/sad.vim'           -- Quick search and replace for Vim
  use 'nvim-lualine/lualine.nvim' -- Awesome vim airline with several options and themes.
  use 'tpope/vim-repeat'          -- Repeat any command with dot .
  use 'nvim-treesitter/nvim-treesitter'
  use 'kyazdani42/nvim-web-devicons'

  -- Git plugins
  use 'tpope/vim-fugitive'

  -- Language Support (LSP)
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- Fuzzy finder
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Quickly navigation among Elixir files
  use 'tpope/vim-projectionist'
  use 'dkuku/vim-projectionist-elixir'

  -- Colorschemas
  use 'rose-pine/neovim'
  use 'EdenEast/nightfox.nvim'
  -- use 'folke/tokyonight.nvim'
  -- use 'feliperenan/nord-vim'
  -- use 'nightsense/snow'
  -- use 'drewtempelmeyer/palenight.vim'

  -- Insert or delete brackets, parens, quotes in pair.
  -- 'jiangmiao/auto-pairs'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

