" List of plugins used in ~/dotfiles/vim/init.vim

call plug#begin('~/.vim/plugged')
  Plug 'arcticicestudio/nord-vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'sheerun/vim-polyglot'
  Plug 'janko-m/vim-test'
  Plug 'tpope/vim-repeat'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-fugitive'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'kien/ctrlp.vim'
  Plug 'Valloric/MatchTagAlways'
  Plug 'rking/ag.vim'
  Plug 'danro/rename.vim'
  Plug 'tpope/vim-surround'
  Plug 'slashmili/alchemist.vim'
  Plug 'tpope/vim-endwise'
  Plug 'scrooloose/nerdtree'
  Plug 'neomake/neomake'
  Plug 'vim-scripts/tComment'
  Plug 'mhinz/vim-mix-format'
  " Plugin to enable vim to open the file in the spefic line
  " ex. app/models/user.rb:1337
  Plug 'bogado/file-line'
  Plug 'Chiel92/vim-autoformat'
  Plug 'junegunn/vim-easy-align'
  " Open the current file on GitHub
  Plug 'tyru/open-browser.vim'
  Plug 'tyru/open-browser-github.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'bling/vim-bufferline'
  Plug 'slim-template/vim-slim'

  " Vim plugin to SUPPORT writing user-defined text objects, especially, simple text objects which
  " can be defined by regular expression. This plugin only provides functions to support writing
  " user-defined text objects, and this plugin does not provide any useful text objects.
  Plug 'kana/vim-textobj-user'

  " Depends on 'vim-textobj-user'.
  " Plugin to provide text objects to select a portion of the current line
  Plug 'kana/vim-textobj-line'

  " Depends on 'vim-textobj-user'.
  " Elixir text objects include: 'setup_all', 'setup', 'describe', 'test', 'unless', 'quote',
  " 'case', 'cond', 'when', 'with', 'for', 'if', 'defprotocol', 'defmodule', 'defmacro', 'defmacrop',
  " 'defimpl', 'defp', 'def'.
  Plug 'andyl/vim-textobj-elixir'

  " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

colorscheme nord
