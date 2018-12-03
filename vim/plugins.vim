" List of plugins used in ~/dotfiles/vim/init.vim

call plug#begin('~/.vim/plugged')
  Plug 'mattn/emmet-vim'
  Plug 'nanotech/jellybeans.vim'
  Plug 'lifepillar/vim-solarized8'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'mattn/gist-vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'kana/vim-textobj-user'
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
  Plug 'Asheq/close-buffers.vim'
  Plug 'junegunn/vim-easy-align'
call plug#end()


set background=light
colorscheme solarized8
" colorscheme jellybeans
