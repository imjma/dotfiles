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
Plug 'christoomey/vim-tmux-navigator'

" Language
Plug 'scrooloose/syntastic'

" Enhance
Plug 'godlygeek/tabular'
Plug 'matze/vim-move'

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

"===============================================================================
" Better Search 
"===============================================================================

" set search case to a good configuration http://vim.wikia.com/wiki/Searching 
set ignorecase
set smartcase

" search characters as they're entered
set incsearch
" don't highlight all search matches
" set nohlsearch
" search highlight
set hlsearch

" Text display settings
set linebreak
set textwidth=120
set autoindent

"These languages have their own tab/indent settings.
autocmd FileType gitcommit setlocal spell

" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell

" Special sets for different filetype
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml,tpl setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType lua setlocal tabstop=2 shiftwidth=2 softtabstop=2

"English spelling checker.
setlocal spelllang=en_us

"Keep 80 columns.
set colorcolumn=120
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/
autocmd WinEnter * match OverLength /\%121v.\+/

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

"===============================================================================
" Keymaps
"===============================================================================

if has('nvim')
    " Hack to get C-h working in NeoVim
    " nmap <bs> <C-W>h
endif

" w!!: Writes using sudo
cnoremap w!! w !sudo tee % >/dev/null

" keyboard shortcuts
" noremap <C-H> <C-W>h
" noremap <C-j> <C-w>j
" noremap <C-k> <C-w>k
" noremap <C-L> <C-W>l

" ==============================
" Window/Tab/Split Manipulation
" ==============================

" Zoom in
map <silent> <leader>gz <C-w>o

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" ============================
" Shortcuts for everyday tasks
" ============================

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
nnoremap <silent> <leader>cf :let @* = expand("%:~")<CR>
nnoremap <silent> <leader>cn :let @* = expand("%:t")<CR>

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

"===============================================================================
" Plugins
"===============================================================================


" Use deoplete.
let g:deoplete#enable_at_startup = 1

" <tab> do completion
inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()

"Syntastic-related configurations.
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"vim-airline
let g:airline_powerline_fonts = 1

" vim-move
" let g:move_key_modifier = 'C'

"===============================================================================
" Local Settings
"===============================================================================

" Go crazy!
if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  "
  " set autowrite
  " set nocursorline
  " set nowritebackup
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  "
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  " noremap! jj <ESC>
  source ~/.vimrc.local
endif
