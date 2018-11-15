" vim-plug {{{

call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'

" Browsing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'zhaocai/GoldenView.Vim'
Plug 'rking/ag.vim'

" Editing
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-surround'
Plug 'Shougo/echodoc.vim'

" Status bar mods
Plug 'bling/vim-airline'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Lint
Plug 'w0rp/ale'

" Language
Plug 'fatih/vim-go' 
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Add plugins to &runtimepath
call plug#end()
" }}}

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set shell=/usr/local/bin/zsh

set background=dark
" colorscheme PaperColor
colorscheme gruvbox
let g:gruvbox_invert_selection = 0
let g:gruvbox_contrast_dark = 'soft'
syntax enable

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

" set showcmd                 " show command in bottom bar
set noshowcmd
set cursorline              " highlight current line
hi CursorLine gui=underline cterm=underline
filetype plugin indent on          " load filetype-specific indent files

set cmdheight=2 " for echodoc

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

set backspace=indent,eol,start
set scrolloff=10             " at least 5 visible lines of text above and below
set list
set listchars=tab:¦\ ,trail:⋅,extends:»,precedes:«,nbsp:␣

" Open split panes to right and bottom
set splitbelow
set splitright

" Search
set hlsearch            " highlight matches

" 120 chars/line {{{
set textwidth=120
" if exists('&colorcolumn')
"     set colorcolumn=120
"     highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"     match OverLength /\%121v.\+/
" endif
" }}}

" folden {{{
" I dislike folding.
" set nofoldenable

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" space open/closes folds
" nnoremap space> za
nnoremap z] zo]z
nnoremap z[ zo[z
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

set nostartofline    " Keep the cursor on the same column
set modelines=2

" Keybindings {{{
let mapleader="\ "       " leader is comma

" edit vimrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <leader>a :Ag<space>

" map semicolon to colon to avoid the extra shift keypress
nmap ;; :

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
" nnoremap <silent> ss <C-w>s

" Closing splits
nnoremap <leader>q :close<cr>

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

" These mappings will make it so that going to the next one in a search will
" " center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

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

" }}}

" Plugin: deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}

" Plugin: zchee/deoplete-go {{{
" neocomplete like
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect

" Path to python interpreter for neovim
let g:python3_host_prog  = '/usr/local/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1

" Enable completing of go pointers
let g:deoplete#sources#go#pointer = 1

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" }}}

" Plugin: neosnippet {{{

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
\ pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" }}}

" Plugin: FZF {{{

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

" Plugin: nerdtree {{{

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

" Plugin: nerdcommenter {{{

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

" Plugin: goldenview {{{

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

" Plugin: ag.vim {{{

if executable('ag')
    let &grepprg = 'ag --nogroup --nocolor --column'
else
    let &grepprg = 'grep -rn $* *'
endif
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

" }}}

" Plugin: bling/vim-airline {{{

let g:airline_powerline_fonts = 0
let g:airline#extensions#branch#enabled = 1

" let g:airline#extensions#syntastic#enabled = 1
let g:airline_section_warning = '✗'
let g:airline_section_error = '⚠'
let g:airline#extensions#tagbar#enabled = 0

"Tabline
" let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#syntastic#enabled = 1
" let g:airline_section_warning = '✗'
" let g:airline_section_error = '⚠'

"Colorscheme
" let g:airline_theme='papercolor'

" }}}

" Plugin: w0rp/ale {{{

" Error and warning signs.
" let g:ale_sign_error = '⤫'
" let g:ale_sign_warning = '⚠'
" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '--'

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

" augroup Ale
"     autocmd!
"     autocmd VimEnter * ALEDisable
" augroup END

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" }}}

" gitgutter {{{
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

" Plugin: fatih/vim-go {{{

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

" Language: Golang {{{

au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

au FileType go nmap <leader>gt :GoDeclsDir<cr>
au FileType go nmap <leader>gc :GoCoverageToggle -short<cr>
au FileType go nmap <leader>gr :GoReferrers<cr>
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <Leader>gi <Plug>(go-info)

" set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
" autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

" }}}

" Language: gitconfig {{{

au FileType gitconfig set noexpandtab
au FileType gitconfig set shiftwidth=2
au FileType gitconfig set softtabstop=2
au FileType gitconfig set tabstop=2

" }}}

" Language: JavaScript {{{

au FileType javascript set expandtab
au FileType javascript set shiftwidth=2
au FileType javascript set softtabstop=2
au FileType javascript set tabstop=2

" }}}

" Language: JSON {{{

au FileType json set expandtab
au FileType json set shiftwidth=2
au FileType json set softtabstop=2
au FileType json set tabstop=2

" }}}

" Language: Markdown {{{

au FileType markdown setlocal spell
au FileType markdown set expandtab
au FileType markdown set shiftwidth=4
au FileType markdown set softtabstop=4
au FileType markdown set tabstop=4
au FileType markdown set syntax=markdown

" }}}
