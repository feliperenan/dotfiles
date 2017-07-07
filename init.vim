set shell=/bin/zsh

set re=1
set hidden 
" Leader key
let mapleader = "\<SPACE>"
let g:mapleader = "\<SPACE>"

" Remove scrolls bars from macvim
set guioptions=

" Shortcut to open vim rc
nmap <leader>vr :sp $MYVIMRC<cr>

" Shortcut to reload vim config
nmap <leader>so :source $MYVIMRC<cr>

" 2 spaces forever :)
set tabstop=2
set shiftwidth=2 
set expandtab
set autoread


" Init Plugins
call plug#begin('~/.vim/plugged')
  Plug 'mattn/emmet-vim'
  Plug 'nanotech/jellybeans.vim'
  Plug 'AlessandroYorba/Sierra'
  Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'bling/vim-airline'
  Plug 'mattn/webapi-vim'
  Plug 'mattn/gist-vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'janko-m/vim-test'
  Plug 'tpope/vim-repeat'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'posva/vim-vue'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-bundler'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'kien/ctrlp.vim'
  Plug 'Valloric/MatchTagAlways'
  Plug 'rking/ag.vim'
  Plug 'kchmck/vim-coffee-script'
  Plug 'danro/rename.vim'
  Plug 'tpope/vim-surround'
  Plug 'elixir-lang/vim-elixir'
  Plug 'tpope/vim-endwise'
  Plug 'sjbach/lusty'
  Plug 'vim-ruby/vim-ruby'
  Plug 'scrooloose/nerdtree'
  Plug 'w0rp/ale'
  Plug 'chrisbra/vim-diff-enhanced'
  Plug 'vim-scripts/tComment'
  Plug 'maralla/completor.vim'
  " Snippets
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
call plug#end()

" Snippets config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

set termguicolors

syntax enable
colorscheme onedark
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic
" let g:onedark_terminal_italics=1
let g:airline_theme='onedark'

set visualbell    " don't beep
set noerrorbells  " don't beep
set autoread " Auto read when a file is changed on disk"
set autoindent
set copyindent
set number " line numbers
set relativenumber number
set showmode " always show mode
set showcmd " Show (partial) command in status line.
set noshowmode  " dont show default status line
set cursorline " highlight current line
set history=100
set undolevels=10000  " Use more levels of undo"
" dont use backup files
set nobackup
set noswapfile
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp   " store swap files here
" Search things
set incsearch   " show search matches as you type
set ignorecase  " case insensitive search
set smartcase   " If a capital letter is included in search, make it case-sensitive
set nohlsearch  " dont highlight search results
set ttimeoutlen=0 " Remove 'esc' delay
set tabstop=2
set shiftwidth=2

" Start find/replace
noremap <leader>r :%s/

" Paste mode
nnoremap <leader>o :set invpaste<CR>

" Tired of :w :q etc
nnoremap ;w :w<CR>
nnoremap ;q :q<CR>
nnoremap ;wq :wq<CR>
nnoremap ;qa :qa<CR>

" Selecting last pasted or changed text
nnoremap <expr> <leader>gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Open splits on right and below
set splitbelow
set splitright

" Open ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
noremap <leader>p :CtrlP<CR>
noremap <leader>. :CtrlPTag<CR>
noremap <leader>b :CtrlPBuffer<CR>
noremap <leader>m :CtrlPMRU<CR>

" Ctrlp ignore file list
let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|target|dist|coverage)|(\.(swp|ico|git|svn))$'

" Ctrlp starting in current directory
let g:ctrlp_working_path_mode = 'a'

" allow saving a sudo file if forgot to open as sudo
cmap w!! w !sudo tee % >/dev/null

" Relative numbers
set relativenumber " use relative numbers
autocmd InsertEnter * silent! : norelativenumber
autocmd InsertLeave,BufNewFile,VimEnter * silent! : relativenumber

" Disable arrow keys"
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
   let t:curwin = winnr()
   exec "wincmd ".a:key
   if (t:curwin == winnr())
       if (match(a:key,'[jk]'))
           wincmd v
       else
           wincmd s
       endif
       exec "wincmd ".a:key
   endif
endfunction

" Split navigation with something fancy :)
map <silent> <leader>h :call WinMove('h')<CR>
map <silent> <leader>j :call WinMove('j')<CR>
map <silent> <leader>k :call WinMove('k')<CR>
map <silent> <leader>l :call WinMove('l')<CR>

" Toggle NerdTree
noremap <Leader>f :NERDTreeToggle<CR>

" Open NerdTree on current file
nnoremap <silent> <Leader>c :NERDTreeFind<CR>
" It closes NerdTree automatically
let NERDTreeQuitOnOpen = 1
" Making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Add javascript syntax to es6, es7 files
autocmd BufNewFile,BufRead *.es6   set syntax=javascript
autocmd BufNewFile,BufRead *.es7   set syntax=javascript

" Add javascript syntax to typescript
autocmd BufNewFile,BufRead *.ts set syntax=javascript

" Javascript erb files
autocmd BufRead,BufNewFile *.js.erb  set filetype=javascript
autocmd BufRead,BufNewFile *.jsx.erb set filetype=javascript

" Add html syntax to ejs
autocmd BufNewFile,BufRead *.ejs set syntax=html

" Add html syntax to nunjucks
autocmd BufNewFile,BufRead *.nunjucks set syntax=html

" Add json syntax to babelrc
autocmd BufNewFile,BufRead *.babelrc set syntax=json

" Add spell checking and wrap at 72 columns git commit message
autocmd Filetype gitcommit setlocal spell textwidth=72

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Run buffer in postgres as a query
map <leader>rq :w !psql -d PremiosOnline_development -f -<CR>

" Change buffers
map ,, :bnext<cr>
map ,. :bprevious<cr>

command! Vb normal! <C-v>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Set terminal to vim-test
let test#strategy = "neovim"

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Indentation config
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

" Gist config
let g:gist_show_privates = 1
let g:gist_post_private = 1

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Ruby / Rails
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate

nmap <silent> <leader>tt :TestFile<CR>
nmap <silent> <leader>ts :TestNearest<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" Linters setup
set nocompatible
filetype off
let &runtimepath.=',~/.vim/bundle/ale'
filetype plugin on
let g:ale_linters = { 'javascript': ['eslint', 'jshint'], 'ruby': ['rubocop'] }

" JS beautify
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

" Vue JS config
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

" Git commands
command! -nargs=+ Tg :T git <args>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Indentation config
set laststatus=2

" Enable/Disable tabline from vim-airline
" 0 = disable
" 1 = enable
let g:airline#extensions#tabline#enabled = 0

