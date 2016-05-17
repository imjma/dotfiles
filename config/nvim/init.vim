"No compatibility to traditional vi
set nocompatible

filetype off

" vim-plug
call plug#begin('~/.config/nvim/plugged')

"Plugin list ------------------------------------------------------------------

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

" Ctrl-P - Fuzzy file search
Plug 'kien/ctrlp.vim'

" Status bar mods
Plug 'bling/vim-airline'

" Git
Plug 'airblade/vim-gitgutter'

" Interface
Plug 'altercation/vim-colors-solarized'

" Language
Plug 'scrooloose/syntastic'

" Enhance
Plug 'godlygeek/tabular'

" Add plugins to &runtimepath
call plug#end()

filetype plugin on

" Show number
set number

" Syntax highlighting.
syntax on

" Turn on relative number mode
set relativenumber

" Open split panes to right and bottom
set splitbelow
set splitright

" Softtab -- use spaces instead tabs.
set expandtab
set tabstop=4 shiftwidth=4 sts=4
set autoindent nosmartindent

" Make search act like search in modern browsers
set incsearch

" search highlight
set hlsearch

" Text display settings
set linebreak
set textwidth=120
set autoindent

"These languages have their own tab/indent settings.
au FileType cpp    setl ts=2 sw=2 sts=2
au FileType ruby   setl ts=2 sw=2 sts=2
au FileType yaml   setl ts=2 sw=2 sts=2
au FileType html   setl ts=2 sw=2 sts=2
au FileType jinja  setl ts=2 sw=2 sts=2
au FileType lua    setl ts=2 sw=2 sts=2
au FileType haml   setl ts=2 sw=2 sts=2
au FileType sass   setl ts=2 sw=2 sts=2
au FileType scss   setl ts=2 sw=2 sts=2
au FileType make   setl ts=4 sw=4 sts=4 noet
au FileType gitcommit setl spell

"English spelling checker.
setlocal spelllang=en_us

"Keep 80 columns.
set colorcolumn=80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
autocmd WinEnter * match OverLength /\%81v.\+/

" I dislike folding.
set nofoldenable

" I dislike visual bell as well.
set novisualbell

"===============================================================================
" Leader Key Mappings
"===============================================================================

" Map leader and localleader key to comma
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

set bg=dark
colorscheme solarized 

" Use deoplete.
let g:deoplete#enable_at_startup = 1

"Syntastic-related configurations.
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"vim-airline
let g:airline_powerline_fonts = 1

