" =============================================================================
" vim-plug {{{
" =============================================================================

call plug#begin('~/.config/nvim/plugged')

" Plugin list
" function! DoRemote(arg)
"   UpdateRemotePlugins
" endfunction
" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" Plug 'roxma/nvim-completion-manager'
" assuming your using vim-plug: https://github.com/junegunn/vim-plug
Plug 'ncm2/ncm2'
" ncm2 requires nvim-yarp
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-go'

" Colorscheme
Plug 'sjl/badwolf'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'
Plug 'arcticicestudio/nord-vim'
Plug 'ajh17/Spacegray.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'itchyny/landscape.vim'

" Browsing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'zhaocai/GoldenView.Vim'
Plug 'rking/ag.vim'

" Status bar mods
Plug 'bling/vim-airline'

" Edit
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Plug 'ervandew/supertab'
Plug 'terryma/vim-multiple-cursors'
" Plug 'jiangmiao/auto-pairs'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Interface

" Lint
" Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'

" Lang
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar'
Plug 'honza/vim-snippets'

" Snippets
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'

" Ruby
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'

" React
Plug 'mxw/vim-jsx'
Plug 'justinj/vim-react-snippets'

" Go
Plug 'sebdah/vim-delve'

" Language support
Plug 'StanAngeloff/php.vim'                    " PHP syntax highlighting
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'} " PHP auto completion
Plug 'aklt/plantuml-syntax'                    " PlantUML syntax highlighting
Plug 'cespare/vim-toml'                        " toml syntax highlighting
Plug 'chr4/nginx.vim'                          " nginx syntax highlighting
Plug 'dag/vim-fish'                            " Fish syntax highlighting
Plug 'digitaltoad/vim-pug'                     " Pug syntax highlighting
Plug 'fatih/vim-go'                            " Go support
" Plug 'fishbullet/deoplete-ruby'                " Ruby auto completion
Plug 'hashivim/vim-terraform'                  " Terraform syntax highlighting
Plug 'kchmck/vim-coffee-script'                " CoffeeScript syntax highlighting
Plug 'kylef/apiblueprint.vim'                  " API Blueprint syntax highlighting
Plug 'leafgarland/typescript-vim'              " TypeScript syntax highlighting
Plug 'lifepillar/pgsql.vim'                    " PostgreSQL syntax highlighting
Plug 'mxw/vim-jsx'                             " JSX syntax highlighting
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'pangloss/vim-javascript'                 " JavaScript syntax highlighting
Plug 'plasticboy/vim-markdown'                 " Markdown syntax highlighting
Plug 'rodjek/vim-puppet'                       " Puppet syntax highlighting
Plug 'tclh123/vim-thrift'                      " Thrift syntax highlighting
" Plug 'zchee/deoplete-go', { 'do': 'make'}      " Go auto completion
" Plug 'zchee/deoplete-jedi'                     " Go auto completion

" Add plugins to &runtimepath
call plug#end()

" }}}
" =============================================================================
" Basic Settings {{{
" =============================================================================

" Colors
set background=dark
" colorscheme seoul256
colorscheme PaperColor
" let g:gruvbox_invert_selection = 0
" let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox
" colorscheme landscape

syntax enable

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

" 120 chars/line
set textwidth=120
if exists('&colorcolumn')
    set colorcolumn=120
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%121v.\+/
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
nnoremap z] zo]z
nnoremap z[ zo[z

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
" %f Relative ath to current directory
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
set statusline=%<[%n]\ %f\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P
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

if has('nvim')
    set mouse=
else
    set mouse=a    " mouse
endif

set nostartofline    " Keep the cursor on the same column

set modelines=2

" }}}
" =============================================================================
" Keybindings {{{
" =============================================================================
" Keybindings
let mapleader=","       " leader is comma

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>l :Align
nnoremap <leader>a :Ag<space>
" nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>g :GitGutterToggle<CR>
" nnoremap <leader>a :ALEEnable<CR>

" map semicolon to colon to avoid the extra shift keypress
nmap ;; :

" w!!: Writes using sudo
cnoremap w!! w !sudo tee % >/dev/null

" turn off search highlight
" nnoremap <leader><space> :nohlsearch<CR>
nnoremap <silent> // :nohlsearch<CR>

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

" ,[ Surround a word with [braces]
map <leader>] ysiw]
map <leader>[ ysiw[
vmap <leader>] c[ <C-R>" ]<ESC>
vmap <leader>[ c[<C-R>"]<ESC>

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

" vim-mappings {{{
    " Ctrl+Shift+上下移动当前行
    nnoremap <silent><C-j> :m .+1<CR>==
    nnoremap <silent><C-k> :m .-2<CR>==
    inoremap <silent><C-j> <Esc>:m .+1<CR>==gi
    inoremap <silent><C-k> <Esc>:m .-2<CR>==gi
    " 上下移动选中的行
    vnoremap <silent><C-j> :m '>+1<CR>gv=gv
    vnoremap <silent><C-k> :m '<-2<CR>gv=gv
    " Use tab for indenting in visual mode
    xnoremap <Tab> >gv|
    xnoremap <S-Tab> <gv
    nnoremap > >>_
    nnoremap < <<_
    " press <F7> whenever you want to format
    " your file(re-indent your entire file)
    map <F7> mzgg=G`z
" }}}
" =============================================================================
" ncm2 {{{
" =============================================================================
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
    \ 'name' : 'css',
    \ 'priority': 9,
    \ 'subscope_enable': 1,
    \ 'scope': ['css','scss'],
    \ 'mark': 'css',
    \ 'word_pattern': '[\w\-]+',
    \ 'complete_pattern': ':\s*',
    \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
    \ })

" }}}
" =============================================================================
" FZF {{{
" =============================================================================

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

  " status line
  function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
  endfunction

  autocmd! User FzfStatusLine call <SID>fzf_statusline()
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

" Close vim if NERDTree is the only opened window.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Files to ignore
let NERDTreeIgnore = [
    \ '\~$',
    \ '\.pyc$',
    \ '^\.DS_Store$',
    \ '^node_modules$',
    \ '^.ropeproject$',
    \ '^__pycache__$'
\]

" Show hidden files by default.
let NERDTreeShowHidden = 1

" Allow NERDTree to change session root.
let g:NERDTreeChDirMode = 2

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
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1

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
" Plugin: bling/vim-airline {{{
" =============================================================================

let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1

let g:airline#extensions#syntastic#enabled = 1
let g:airline_section_warning = '✗'
let g:airline_section_error = '⚠'
let g:airline#extensions#tagbar#enabled = 0

"Tabline
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#syntastic#enabled = 1
let g:airline_section_warning = '✗'
let g:airline_section_error = '⚠'

"Colorscheme
" let g:airline_theme='papercolor'

" }}}
" =============================================================================
" Plugin: majutsushi/tagbar {{{
" =============================================================================

nnoremap <leader>\ :TagbarToggle<CR>

" }}}
" =============================================================================
" Plugin: plasticboy/vim-markdown {{{
" =============================================================================

" Disable folding
let g:vim_markdown_folding_disabled = 1

" Auto shrink the TOC, so that it won't take up 50% of the screen
let g:vim_markdown_toc_autofit = 1

" }}}
" =============================================================================
" Plugin: sebdah/vim-delve {{{
" =============================================================================

" Set the Delve backend.
let g:delve_backend = "native"

" }}}
" =============================================================================
" Plugin: terryma/vim-multiple-cursors {{{
" =============================================================================

let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Switch to multicursor mode with ,mc
let g:multi_cursor_start_key=',mc'

" }}}
" =============================================================================
" Plugin: w0rp/ale {{{
" =============================================================================

" Error and warning signs.
" let g:ale_sign_error = '⤫'
" let g:ale_sign_warning = '⚠'

" Using special space: U+2000 (EN QUAD)
let g:ale_set_loclist=1
let g:ale_sign_error=' ●'
let g:ale_sign_warning=' ●'
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_filetype_changed=1
let g:ale_set_highlights=1
let g:ale_set_signs=1

nmap [w <plug>(ale_previous_wrap)
nmap ]w <plug>(ale_next_wrap)
nmap üw <plug>(ale_previous_wrap)
nmap ¨w <plug>(ale_next_wrap)

augroup Ale
    autocmd!
    autocmd VimEnter * ALEDisable
augroup END

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" }}}
" =============================================================================
" gitgutter {{{
" =============================================================================
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'
" }}}
" =============================================================================
" Plugin: fatih/vim-go {{{
" =============================================================================

" Run goimports when running gofmt
let g:go_fmt_command = "goimports"

" Enable syntax highlighting per default
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1

" Show type information
let g:go_auto_type_info = 1

" Highlight variable uses
let g:go_auto_sameids = 1

" Fix for location list when vim-go is used together with Syntastic
let g:go_list_type = "quickfix"

" gometalinter configuration
let g:go_metalinter_command = ""
let g:go_metalinter_deadline = "5s"
let g:go_metalinter_enabled = [
    \ 'deadcode',
    \ 'gas',
    \ 'goconst',
    \ 'gocyclo',
    \ 'golint',
    \ 'gosimple',
    \ 'ineffassign',
    \ 'vet',
    \ 'vetshadow'
\]

" Set whether the JSON tags should be snakecase or camelcase.
let g:go_addtags_transform = "snakecase"

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
" =============================================================================
" Language: Golang {{{
" =============================================================================

au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

au FileType go nmap <leader>gt :GoDeclsDir<cr>
au FileType go nmap <leader>gct :GoCoverageToggle -short<cr>
au FileType go nmap <leader>gd <Plug>(go-def)

" }}}
" =============================================================================
" Language: gitconfig {{{
" =============================================================================

au FileType gitconfig set noexpandtab
au FileType gitconfig set shiftwidth=2
au FileType gitconfig set softtabstop=2
au FileType gitconfig set tabstop=2

" }}}
" =============================================================================
" Language: JavaScript {{{
" =============================================================================

au FileType javascript set expandtab
au FileType javascript set shiftwidth=2
au FileType javascript set softtabstop=2
au FileType javascript set tabstop=2

" }}}
" =============================================================================
" Language: JSON {{{
" =============================================================================

au FileType json set expandtab
au FileType json set shiftwidth=2
au FileType json set softtabstop=2
au FileType json set tabstop=2

" }}}
" =============================================================================
" Language: Markdown {{{
" =============================================================================

au FileType markdown setlocal spell
au FileType markdown set expandtab
au FileType markdown set shiftwidth=4
au FileType markdown set softtabstop=4
au FileType markdown set tabstop=4
au FileType markdown set syntax=markdown

" }}}
" =============================================================================
" Language: Ruby {{{
" =============================================================================

au FileType ruby set expandtab
au FileType ruby set shiftwidth=2
au FileType ruby set softtabstop=2
au FileType ruby set tabstop=2

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
"
