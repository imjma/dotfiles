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
NeoBundle 'Shougo/vimfiler'

" Fuzzy search
" NeoBundle 'Shougo/unite.vim'
NeoBundle 'kien/ctrlp.vim'

" Code completion
NeoBundle 'Shougo/neocomplete.vim'
if s:is_macvim
  " NeoBundle 'Valloric/YouCompleteMe'
endif
NeoBundle 'ervandew/supertab'

" Snippets
NeoBundle 'honza/vim-snippets'

" Comments
NeoBundle 'scrooloose/nerdcommenter'

" Color themems
NeoBundle 'nanotech/jellybeans.vim'

" Git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

" Ident
NeoBundle 'nathanaelkane/vim-indent-guides'

" UI Enchance
NeoBundle 'yonchu/accelerated-smooth-scroll'

" Misc
NeoBundle 'sjl/gundo.vim'

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
set background=dark

" Turn on line number
set number

" Sets how many lines of history vim has to remember
set history=10000

" Set to auto read when a file is changed from the outside
set autoread

" Display unprintable chars
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

" 256bit terminal
set t_Co=256

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=10

" How many lines to scroll at a time, make scrolling appears faster
set scrolljump=3

" Min width of the number column to the left
set numberwidth=1

" Open all folds initially
set foldmethod=indent
set foldlevelstart=99

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Set backspace config
set backspace=eol,start,indent

" Case insensitive search
set ignorecase
set smartcase

" Make search act like search in modern browsers
set incsearch

" Make regex a little easier to type
set magic

" Show incomplete commands
set showcmd

" Turn off sound
set vb
set t_vb=

" Explicitly set encoding to utf-8
set encoding=utf-8

" Column width indicator
set colorcolumn=+1

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Tab settings
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab

" Text display settings
set linebreak
set textwidth=80
set autoindent
set nowrap
set whichwrap+=h,l,<,>,[,]

" Special sets for different filetype
autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml,tpl setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120

" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" Spelling highlights. Use underline in term to prevent cursorline highlights
" from interfering
if !has("gui_running")
  hi clear SpellBad
  hi SpellBad cterm=underline ctermfg=red
  hi clear SpellCap
  hi SpellCap cterm=underline ctermfg=blue
  hi clear SpellLocal
  hi SpellLocal cterm=underline ctermfg=blue
  hi clear SpellRare
  hi SpellRare cterm=underline ctermfg=blue
endif

"===============================================================================
" Leader Key Mappings
"===============================================================================

" Map leader and localleader key to comma
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

"===============================================================================
" Normal Mode Shift Key Mappings
"===============================================================================

" Shift-Tab: NERDTree
nnoremap <silent> <S-Tab> :NERDTreeToggle<CR>

" Q: Closes the window
" nnoremap Q :q<cr>

" W: Save
nnoremap W :w<cr>

"===============================================================================
" NERDTree
"===============================================================================

let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']

"===============================================================================
" Ident Guides
"===============================================================================

let g:indent_guides_enable_on_vim_startup = 1

"===============================================================================
" vim-airline
"===============================================================================

" Always show the statusline
set laststatus=2

"===============================================================================
" ctrlp 
"===============================================================================

let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_height = 30

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
if s:is_windows
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
endif
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

