" https://github.com/square/maximum-awesome
" https://github.com/skwp/dotfiles

set nocompatible               " Be iMproved
filetype off                   " required

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
" if filereadable(expand("~/.vim/vundle.vim"))
"   source ~/.vim/vundle.vim
" endif
if filereadable(expand("~/.vim/plug.vim"))
  source ~/.vim/plug.vim
endif

"===============================================================================
" Detect OS
"===============================================================================

let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macvim = has('gui_macvim')

"===============================================================================
" General Settings
"===============================================================================

syntax enable

if has("gui_running")
  " 256bit terminal
  set t_Co=256

  " Show tab number (useful for Cmd-1, Cmd-2.. mapping)
  " For some reason this doesn't work as a regular set command,
  " (the numbers don't show up) so I made it a VimEnter event
  autocmd VimEnter * set guitablabel=%N:\ %t\ %M

  set lines=60
  set columns=190

  if has("gui_gtk2")
    set guifont=Monaco\ 12,Inconsolata\ XL\ 12,Inconsolata\ 15
  else
    set guifont=Code\ Source\ Pro:h11,Monaco:h12,Inconsolata\ XL:h17,Inconsolata:h20
  end

else
  let g:CSApprox_loaded = 1

  " For people using a terminal that is not Solarized
  " let g:solarized_termcolors=256
  " let g:solarized_termtrans=1
endif

" Colorscheme
" colorscheme material-theme
" colorscheme base16-default
" colorscheme base16-tomorrow
" colorscheme jellybeans
" colorscheme hybrid
" colorscheme solarized
" colorscheme seti
" colorscheme molokai
colorscheme seoul256
set background=dark

" Turn on relative number mode
set relativenumber

" Turn on line number
set number

" Open split panes to right and bottom
set splitbelow
set splitright

" Sets how many lines of history vim has to remember
set history=10000

" Set to auto read when a file is changed from the outside
set autoread

" Display unprintable chars
set list
set listchars=tab:▸\ ,trail:▫,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

" Disable the scrollbars (NERDTree)
set guioptions-=r
set guioptions-=L

" Disable the macvim toolbar
set guioptions-=T

set lazyredraw

" ================ Scrolling ========================

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=10

" How many lines to scroll at a time, make scrolling appears faster
set scrolljump=3

set sidescrolloff=15
set sidescroll=1

" Min width of the number column to the left
set numberwidth=1

" ================ Folds ============================

" Open all folds initially
set foldmethod=indent   " fold based on indent
set foldlevelstart=99
set nofoldenable        " dont fold by default

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

" search highlight
set hlsearch

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

" ================ Turn Off Swap Files ==============

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" ================ Indentation ======================

" Tab settings
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab

" Text display settings
set linebreak
set textwidth=120
set autoindent
set nowrap
set whichwrap+=h,l,<,>,[,]

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
if s:is_windows
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
endif


" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell
" extra rails.vim help
autocmd User Rails silent! Rnavcommand decorator      app/decorators            -glob=**/* -suffix=_decorator.rb
autocmd User Rails silent! Rnavcommand observer       app/observers             -glob=**/* -suffix=_observer.rb
autocmd User Rails silent! Rnavcommand feature        features                  -glob=**/* -suffix=.feature
autocmd User Rails silent! Rnavcommand job            app/jobs                  -glob=**/* -suffix=_job.rb
autocmd User Rails silent! Rnavcommand mediator       app/mediators             -glob=**/* -suffix=_mediator.rb
autocmd User Rails silent! Rnavcommand stepdefinition features/step_definitions -glob=**/* -suffix=_steps.rb
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Special sets for different filetype
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml,tpl setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120

" Enable clipboard if possible
if executable('pbcopy') || executable('xclip') || has('clipboard')
    if has('unnamedplus') " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
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

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP


"===============================================================================
" Leader Key Mappings
"===============================================================================

" Map leader and localleader key to comma
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

" ================ Plugins Settings ========================
so ~/.vim/conf.vim

"===============================================================================
" NERDTree
"===============================================================================

let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let g:NERDSpaceDelims=1

"===============================================================================
" Ident Guides
"===============================================================================

let g:indent_guides_enable_on_vim_startup = 1

"===============================================================================
" gitgutter
"===============================================================================
let g:gitgutter_enabled = 0

let g:jsx_ext_required = 0 

" =============================================================================
" atuocmd {{{
" =============================================================================

" https://raw.githubusercontent.com/ziz/vimrc/master/vim/inc/autocmd.vim
augroup invisible_chars " {{{
    au!

    " Show invisible characters in all of these files
    autocmd filetype vim setlocal list
    autocmd filetype php setlocal list
    autocmd filetype python,rst setlocal list
    autocmd filetype ruby setlocal list
    autocmd filetype javascript,css setlocal list
augroup END " }}}

augroup file_type " {{{
    au!

    "These languages have their own tab/indent settings.
    autocmd FileType gitcommit setlocal spell

    " md is markdown
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.md set spell

    " Special sets for different filetype
    autocmd FileType ruby,erb setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
    autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    autocmd FileType html,htmldjango,xhtml,haml,tpl setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
    autocmd FileType sass,scss,css setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    autocmd FileType lua setlocal tabstop=2 shiftwidth=2 softtabstop=2

augroup END " }}}

augroup tmux " {{{
    au!
    " Automatic rename of tmux window
    if exists('$TMUX') && !exists('$NORENAME')
        autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
        autocmd VimLeave * call system('tmux set-window automatic-rename on')
    endif
augroup END " }}}

" }}}
"===============================================================================
"" Local Settings
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
