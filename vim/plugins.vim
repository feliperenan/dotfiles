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
call plug#end()

colorscheme nord
