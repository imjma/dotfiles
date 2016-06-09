" =============================================================================
" vim-plug {{{
" =============================================================================

call plug#begin('~/.config/nvim/plugged')

" Plugin list
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

" Colorscheme
Plug 'sjl/badwolf'
Plug 'junegunn/seoul256.vim'

" Browsing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'zhaocai/GoldenView.Vim'
Plug 'rking/ag.vim'

" Edit
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Interface

" Lint
Plug 'scrooloose/syntastic', { 'on': 'SyntasticCheck' }

" Lang
" Ruby
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'

" Add plugins to &runtimepath
call plug#end()

" }}}
" =============================================================================
" Basic Settings {{{
" =============================================================================

" Colors 
colorscheme badwolf
syntax enable

" Spaces & Tabs
set tabstop=4     " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4
set expandtab     " tabs are spaces

" UI

" linenumber {{{
" set number                  " show line numbers

" Default show linenumber
if !exists('g:noshowlinenumber')
    let g:noshowlinenumber = 0
endif
if (g:noshowlinenumber == 1)
    set nonumber norelativenumber
else
    set number relativenumber
endif

" Use absolute linenum in Insert mode; relative linenum in Normal mode
autocmd FocusLost,InsertEnter * :call UseAbsNum()
autocmd FocusGained,InsertLeave * :call UseRelNum()

function! UseAbsNum()
    let b:fcStatus = &foldcolumn
    setlocal foldcolumn=0 " Don't show foldcolumn in Insert mode
    if (g:noshowlinenumber == 1) || exists('#goyo')
        set nonumber norelativenumber
    else
        set number norelativenumber
    endif
endfunction

function! UseRelNum()
    if !exists('b:fcStatus')
        let b:fcStatus = &foldcolumn
    endif
    if b:fcStatus == 1
        setlocal foldcolumn=1 " Restore foldcolumn in Normal mode
    endif
    if (g:noshowlinenumber == 1) || exists('#goyo')
        set nonumber norelativenumber
    else
        set number relativenumber
    endif
endfunction

" }}}

set showcmd                 " show command in bottom bar
set cursorline              " highlight current line
filetype plugin indent on          " load filetype-specific indent files

set wildmenu                " visual autocomplete for command menu
set wildmode=list:longest
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

set lazyredraw              " redraw only when we need to.
set showmatch               " highlight matching [{()}]
set matchtime=2

set backspace=indent,eol,start
set scrolloff=5             " at least 5 visible lines of text above and below
set list
" set listchars=tab:▸\ ,trail:▫,extends:❯,precedes:❮,nbsp:␣,eol:¬
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:»,precedes:«,nbsp:␣

" Enable clipboard if possible
if executable('pbcopy') || executable('xclip') || has('clipboard')
    if has('unnamedplus') " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

if !has('nvim')
    set encoding=utf-8
endif

" Use Unix as the standard file type
set fileformats=unix,mac,dos

set whichwrap+=h,l,<,>,[,]    " set iskeyword+=-

" Open split panes to right and bottom
set splitbelow
set splitright

" Search
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" 80 chars/line
set textwidth=0
if exists('&colorcolumn')
    set colorcolumn=80
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endif

" folden {{{
" I dislike folding.
" set nofoldenable

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" space open/closes folds
nnoremap <space> za

" }}}

" statusline {{{
" always show status line
set laststatus=2
set statusline=%<%f\ " filename
set statusline+=%w%h%m%r " option
set statusline+=\ [%{&ff}]/%y " fileformat/filetype
set statusline+=\ [%{getcwd()}] " current dir
set statusline+=\ [%{&encoding}] " encoding
set statusline+=%=%-14.(%l/%L,%c%V%)\ %p%% " Right aligned file nav info

" %< Where to truncate
" %n buffer number
" %F Full path
" %m Modified flag: [+], [-]
" %r Readonly flag: [RO]
" %y Type:          [vim]
" fugitive#statusline()
" %= Separator
" %-14.(...)
" %l Line
" %c Column
" %V Virtual column
" %P Percentage
" %#HighlightGroup#
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P
silent! if emoji#available()
  let s:ft_emoji = map({
    \ 'c':          'baby_chick',
    \ 'clojure':    'lollipop',
    \ 'coffee':     'coffee',
    \ 'cpp':        'chicken',
    \ 'css':        'art',
    \ 'eruby':      'ring',
    \ 'gitcommit':  'soon',
    \ 'haml':       'hammer',
    \ 'help':       'angel',
    \ 'html':       'herb',
    \ 'java':       'older_man',
    \ 'javascript': 'monkey',
    \ 'make':       'seedling',
    \ 'markdown':   'book',
    \ 'perl':       'camel',
    \ 'python':     'snake',
    \ 'ruby':       'gem',
    \ 'scala':      'barber',
    \ 'sh':         'shell',
    \ 'slim':       'dancer',
    \ 'text':       'books',
    \ 'vim':        'poop',
    \ 'vim-plug':   'electric_plug',
    \ 'yaml':       'yum',
    \ 'yaml.jinja': 'yum'
  \ }, 'emoji#for(v:val)')

  function! S_filetype()
    if empty(&filetype)
      return emoji#for('grey_question')
    else
      return get(s:ft_emoji, &filetype, '['.&filetype.']')
    endif
  endfunction

  function! S_modified()
    if &modified
      return emoji#for('kiss').' '
    elseif !&modifiable
      return emoji#for('construction').' '
    else
      return ''
    endif
  endfunction

  function! S_fugitive()
    if !exists('g:loaded_fugitive')
      return ''
    endif
    let head = fugitive#head()
    if empty(head)
      return ''
    else
      return head == 'master' ? emoji#for('crown') : emoji#for('dango').'='.head
    endif
  endfunction

  let s:braille = split('"⠉⠒⠤⣀', '\zs')
  function! Braille()
    let len = len(s:braille)
    let [cur, max] = [line('.'), line('$')]
    let pos  = min([len * (cur - 1) / max([1, max - 1]), len - 1])
    return s:braille[pos]
  endfunction

  hi def link User1 TablineFill
  let s:cherry = emoji#for('cherry_blossom')
  function! MyStatusLine()
    let mod = '%{S_modified()}'
    let ro  = "%{&readonly ? emoji#for('lock') . ' ' : ''}"
    let ft  = '%{S_filetype()}'
    let fug = ' %{S_fugitive()}'
    let sep = ' %= '
    let pos = ' %l,%c%V '
    let pct = ' %P '

    return s:cherry.' [%n] %F %<'.mod.ro.ft.fug.sep.pos.'%{Braille()}%*'.pct.s:cherry
  endfunction

  " Note that the "%!" expression is evaluated in the context of the
  " current window and buffer, while %{} items are evaluated in the
  " context of the window that the statusline belongs to.
  set statusline=%!MyStatusLine()
endif
" }}}

" I dislike visual bell as well.
set novisualbell

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
    set undodir=/tmp//,.
endif

set diffopt=filler,iwhite    " in diff mode ignore whitespace changes and align

set mouse=a    " mouse

set nostartofline    " Keep the cursor on the same column

set modelines=2

" }}}
" =============================================================================
" Keybindings {{{
" =============================================================================
" Keybindings
let mapleader=","       " leader is comma

" w!!: Writes using sudo
cnoremap w!! w !sudo tee % >/dev/null

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" alias yw to yank the entire word 'yank inner word'
" even if the cursor is halfway inside the word
" FIXME: will not properly repeat when you use a dot (tie into repeat.vim)
nnoremap <leader>yw yiww

" ,ow = 'overwrite word', replace a word with what's in the yank buffer
" FIXME: will not properly repeat when you use a dot (tie into repeat.vim)
nnoremap <leader>ow "_diwhp

" ,# Surround a word with #{ruby interpolation}
map <leader># ysiw#
vmap <leader># c#{<C-R>"}<ESC>

" ," Surround a word with "quotes"
map <leader>" ysiw"
vmap <leader>" c"<C-R>""<ESC>

" ,' Surround a word with 'single quotes'
map <leader>' ysiw'
vmap <leader>' c'<C-R>"'<ESC>

" ,) or ,( Surround a word with (parens)
" " The difference is in whether a space is put in
map <leader>( ysiw(
map <leader>) ysiw)
vmap <leader>( c( <C-R>" )<ESC>
vmap <leader>) c(<C-R>")<ESC>

" ,{ Surround a word with {braces}
map <leader>} ysiw}
map <leader>{ ysiw{
vmap <leader>} c{ <C-R>" }<ESC>
vmap <leader>{ c{<C-R>"}<ESC>

" Make 0 go to the first character rather than the beginning
" of the line. When we're programming, we're almost always
" interested in working with text rather than empty space. If
" you want the traditional beginning of line, use ^
nnoremap 0 ^
nnoremap ^ 0

" highlight last inserted text
nnoremap gV `[v`]

"Go to last edit location with ,.
nnoremap <leader>. '.

"Move back and forth through previous and next buffers
"with ,z and ,x
nnoremap <silent> <leader>z :bp<CR>
nnoremap <silent> <leader>x :bn<CR>

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at 
nnoremap <silent> <leader>cf :let @* = expand("%:~")<CR>
nnoremap <silent> <leader>cn :let @* = expand("%:t")<CR>

" Use Q to intelligently close a window 
" (if there are multiple windows into the same buffer)
" or kill the buffer entirely if it's the last window looking into that buffer
function! CloseWindowOrKillBuffer()
    let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

    " We should never bdelete a nerd tree
    if matchstr(expand("%"), 'NERD') == 'NERD'
        wincmd c
        return
    endif

    if number_of_windows_to_this_buffer > 1
        wincmd c
    else
        bdelete
    endif
endfunction

nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>

" edit vimrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" linenumber {{{
" Toggle showing linenumber
nnoremap <silent> <Leader>n :call ToggleShowlinenum()<CR>
function! ToggleShowlinenum()
    if (g:noshowlinenumber == 0)
        setlocal nonumber norelativenumber
        let g:noshowlinenumber = 1
    else
        setlocal number relativenumber
        let g:noshowlinenumber = 0
    endif
endfunction

" }}}

" }}}
" =============================================================================
" deoplete {{{
" =============================================================================
" enable it in neovim only
if has('nvim')
    " Use deoplete.
    let g:deoplete#enable_at_startup = 1

    " <tab> do completion
    inoremap <silent><expr> <Tab>
                \ pumvisible() ? "\<C-n>" :
                \ deoplete#mappings#manual_complete()
endif

" }}}
" =============================================================================
" FZF {{{
" =============================================================================

if has('nvim')
    let $FZF_DEFAULT_OPTS .= ' --inline-info'
    " let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" search hidden files
if executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
else
    let $FZF_DEFAULT_COMMAND = 'find -L'
endif

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>c :Commits<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" }}}
" ============================================================================
" nerdtree {{{
" ============================================================================

nnoremap <leader>d :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" }}}

" =============================================================================
" vim-easy-align {{{
" =============================================================================

let g:easy_align_delimiters = {
            \ '>': { 'pattern': '>>\|=>\|>' },
            \ '\': { 'pattern': '\\' },
            \ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
            \ ']': {
            \     'pattern':       '\]\zs',
            \     'left_margin':   0,
            \     'right_margin':  1,
            \     'stick_to_left': 0
            \   },
            \ ')': {
            \     'pattern':       ')\zs',
            \     'left_margin':   0,
            \     'right_margin':  1,
            \     'stick_to_left': 0
            \   },
            \ 'f': {
            \     'pattern': ' \(\S\+(\)\@=',
            \     'left_margin': 0,
            \     'right_margin': 0
            \   },
            \ 'd': {
            \     'pattern': ' \ze\S\+\s*[;=]',
            \     'left_margin': 0,
            \     'right_margin': 0
            \   }
            \ }

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nmap gaa ga_

" }}}
" ===============================================================================
" syntastic {{{
" ===============================================================================

let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" }}}
" =============================================================================
" nerdcommenter {{{
" =============================================================================

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" }}}
" =============================================================================
" goldenview {{{
" =============================================================================

let g:goldenview__enable_default_mapping = 0
" let g:goldenview__enable_at_startup = 0
let g:goldenview__ignore_urule = {
            \  'filetype': [
            \    'nerdtree',
            \    'nerd',
            \    'unite'
            \  ],
            \  'buftype': [
            \    'nofile',
            \    'nerd',
            \    'nerdtree'
            \  ]
            \}

let g:goldenview__restore_urule= {
            \  'filetype': [
            \    'nerdtree',
            \    'nerd',
            \    'unite'
            \  ],
            \  'buftype': [
            \    'nofile',
            \    'nerd',
            \    'nerdtree'
            \  ]
            \}

" 1. split to tiled windows
nmap <silent> <leader>wv <plug>GoldenViewSplit

" 2. quickly switch current window with the main pane and toggle back
nmap <silent> <leader>wm <Plug>GoldenViewSwitchMain
nmap <silent> <leader>wt <Plug>GoldenViewSwitchToggle

" 3. jump to next and previous window
nmap <silent> <leader>wn <Plug>GoldenViewNext
nmap <silent> <leader>wp <Plug>GoldenViewPrevious

" 4. toggle auto resize
nmap <silent> <leader>tg :ToggleGoldenViewAutoResize<CR>

" }}}
" =============================================================================
" ag.vim {{{
" =============================================================================

if executable('ag')
    let &grepprg = 'ag --nogroup --nocolor --column'
else
    let &grepprg = 'grep -rn $* *'
endif
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

" }}}
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
    autocmd FileType coffee,javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
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
" =============================================================================
" Local Settings {{{
" =============================================================================

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

" }}}
