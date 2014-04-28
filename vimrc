set nocompatible               " Be iMproved

"===============================================================================
" Detect OS
"===============================================================================
let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macvim = has('gui_macvim')

"===============================================================================
" NeoBundle
"===============================================================================
if has('vim_starting')
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
" NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'kien/ctrlp.vim'
" NeoBundle 'flazz/vim-colorschemes'

" Status line
NeoBundle 'bling/vim-airline' " So much faster than Powerline! :)

" File browsing
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'Xuyuanp/git-nerdtree'

" Fuzzy search
NeoBundle 'Shougo/unite.vim'

" Code completion
" NeoBundle'Shougo/neocomplcache'
" NeoBundle 'vim-scripts/AutoComplPop'
if s:is_macvim
  " NeoBundle 'Valloric/YouCompleteMe'
endif

" Snippets
NeoBundle 'honza/vim-snippets'

" Color themems
NeoBundle 'nanotech/jellybeans.vim'

" Git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

" You can specify revision/branch/tag.
" NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"===============================================================================
" General Settings
"===============================================================================
syntax enable

" Colorscheme
colorscheme jellybeans

" Turn on line number
set number

"===============================================================================
" NERDTree
"===============================================================================
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
