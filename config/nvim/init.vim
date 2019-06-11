" vim-plug {{{

call plug#begin('~/.config/nvim/plugged')

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-tagprefix'
" Plug 'ncm2/ncm2-ultisnips'
" Plug 'ncm2/ncm2-go'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

" Color
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'
Plug 'tomasr/molokai'
Plug 'ryanoasis/vim-devicons'

" Browsing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'zhaocai/GoldenView.Vim'
Plug 'rking/ag.vim'
Plug 'mileszs/ack.vim'
Plug 'Yggdroot/indentLine'

" Editing
Plug 'scrooloose/nerdcommenter'
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-surround'
Plug 'Shougo/echodoc.vim'
Plug 'SirVer/ultisnips'

" Status bar mods
" Plug 'bling/vim-airline'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Lint
Plug 'w0rp/ale'

" Language
Plug 'fatih/vim-go'
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" Plug 'zchee/deoplete-go', { 'do': 'make'}

" Add plugins to &runtimepath
call plug#end()
" }}}

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set shell=/usr/local/bin/zsh

set background=dark
" colorscheme PaperColor
colorscheme gruvbox8
let g:rehash256 = 1 " Something to do with Molokai?
" colorscheme molokai
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

" Toggle showing linenumber
nnoremap <silent> <leader>n :call ToggleShowlinenum()<CR>
function! ToggleShowlinenum()
    if (g:noshowlinenumber == 0)
        setlocal nonumber norelativenumber
        let g:noshowlinenumber = 1
    else
        setlocal number relativenumber
        let g:noshowlinenumber = 0
    endif
endfunction

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
set noshowmode
set cursorline              " highlight current line
hi CursorLine gui=underline cterm=underline
filetype plugin indent on          " load filetype-specific indent files

set cmdheight=2 " for echodoc

set wildmenu                " visual autocomplete for command menu
set wildmode=list:longest,full " List all options and complete
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

set autoread
" au CursorHold * checktime

" Search
set hlsearch            " highlight matches
set ignorecase          " case insensitive

" 120 chars/line {{{
set textwidth=120
set nowrap
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

set clipboard=unnamed

" Keybindings {{{
let mapleader="\<Space>"       " leader is comma

" edit vimrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Exit on j
imap jj <Esc>

nnoremap <leader>a :Rg!<space>

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
" center on the line it's found in.
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

" Plugin: ncm2/ncm2 {{{

" enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-tmux'
" Plug 'ncm2/ncm2-path'

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <TAB> to select the popup menu:
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
" au User Ncm2Plugin call ncm2#register_source({
"     \ 'name' : 'css',
"     \ 'priority': 9,
"     \ 'subscope_enable': 1,
"     \ 'scope': ['css','scss'],
"     \ 'mark': 'css',
"     \ 'word_pattern': '[\w\-]+',
"     \ 'complete_pattern': ':\s*',
"     \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
"     \ })

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
"
" let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
" let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
" let g:UltiSnipsRemoveSelectModeMappings = 0

" }}}

" Plugin: deoplete {{{
" let g:deoplete#enable_at_startup = 1
" }}}

" Plugin: zchee/deoplete-go {{{
" neocomplete like
" set completeopt+=noinsert
" deoplete.nvim recommend
" set completeopt+=noselect

" Path to python interpreter for neovim
if has("mac")
  let g:python3_host_prog  = '/usr/local/bin/python3'
else
  let g:python3_host_prog  = '/usr/bin/python3'
endif
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
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
" if has('conceal')
"   set conceallevel=2 concealcursor=niv
" endif

" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1

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
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --follow -g "!{.git,node_modules}/*" 2>/dev/null'
    command! -bang -nargs=* Rg
	  \ call fzf#vim#grep(
	  \   'rg --column --line-number --no-heading --color=always --smart-case -g "!{*.lock,*-lock.json}" '.shellescape(<q-args>), 1,
	  \   <bang>0 ? fzf#vim#with_preview('up:40%')
	  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
	  \   <bang>0)
elseif executable('ag')
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

" FZF color scheme updater from https://github.com/junegunn/fzf.vim/issues/59
function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['String',       'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['String',       'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code != ''
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ (empty(cols) ? '' : (' --color='.join(cols, ',')))
endfunction

augroup _fzf
  autocmd!
  autocmd VimEnter,ColorScheme * call <sid>update_fzf_colors()
augroup END

let g:fzf_files_options = "--preview 'bat --color \"always\" {}'"
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
let g:goldenview__enable_at_startup = 1
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

" Plugin: ack.vim {{{
" Tell ack.vim to use ripgrep instead
let g:ackprg = 'rg --vimgrep --no-heading'
" }}}

" Plugin: bling/vim-airline {{{

" let g:airline_powerline_fonts = 0
" let g:airline#extensions#branch#enabled = 1

" let g:airline#extensions#syntastic#enabled = 1
" let g:airline_section_warning = '✗'
" let g:airline_section_error = '⚠'
" let g:airline#extensions#tagbar#enabled = 0

"Tabline
" let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#syntastic#enabled = 1
" let g:airline_section_warning = '✗'
" let g:airline_section_error = '⚠'

"Colorscheme
" let g:airline_theme='papercolor'

" }}}

" Plugin: itchyny/lightline.vim {{{

set laststatus=2
set showtabline=2

" let g:lightline = {
"       \ 'component_function': {
"       \   'filename': 'LightLineFilename'
"       \ }
"       \ }
" function! LightLineFilename()
"   return expand('%')
" endfunction

let g:lightline = {
	\ 'colorscheme': 'gruvbox8',
	\ 'active': {
		\   'left': [['mode', 'paste'], ['filename', 'modified']],
		\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
		\ },
	\ 'tabline': {
		\   'left': [['buffers']],
		\   'right': [['thinkvim']],
		\ },
	\ 'component_expand': {
		\   'linter_warnings': 'LightlineLinterWarnings',
		\   'linter_errors': 'LightlineLinterErrors',
		\   'linter_ok': 'LightlineLinterOK',
		\   'buffers': 'lightline#bufferline#buffers'
		\ },
	\ 'component_type': {
		\   'readonly': 'error',
		\   'linter_warnings': 'warning',
		\   'linter_errors': 'error',
		\   'buffers': 'tabsel'
		\ },
	\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" Update the lightline scheme from the colorscheme. Hopefully.
function! s:UpdateLightlineColorScheme()
  let g:lightline.colorscheme = g:colors_name
  call lightline#init()
endfunction

augroup _lightline
  autocmd!
  autocmd User ALELint call s:MaybeUpdateLightline()
  autocmd ColorScheme * call s:UpdateLightlineColorScheme()
augroup END

let g:lightline#bufferline#show_number  = 2

" }}}

" Plugin: w0rp/ale {{{

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '--'

" Using special space: U+2000 (EN QUAD)
let g:ale_set_loclist=1
" let g:ale_sign_error=' ●'
" let g:ale_sign_warning=' ●'
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_filetype_changed=1
let g:ale_set_highlights=1
let g:ale_set_signs=1

highlight link ALEWarningSign String
highlight link ALEErrorSign Title

nmap ]w :ALENextWrap<CR>
nmap [w :ALEPreviousWrap<CR>
nmap <Leader>f <Plug>(ale_fix)

" augroup Ale
"     autocmd!
"     autocmd VimEnter * ALEDisable
" augroup END

" Enable integration with airline.
" let g:airline#extensions#ale#enabled = 1

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
let g:go_auto_type_info = 0

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

" Defx

nnoremap <silent> <Leader>e
                \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>

call defx#custom#option('_', {
	\ 'columns': 'indent:git:icons:filename',
	\ 'winwidth': 30,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'show_ignored_files': 0,
	\ })

autocmd FileType defx call s:defx_my_settings()
	function! s:defx_my_settings() abort
	  " Define mappings
	  nnoremap <silent><buffer><expr> <CR>
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> c
	  \ defx#do_action('copy')
	  nnoremap <silent><buffer><expr> m
	  \ defx#do_action('move')
	  nnoremap <silent><buffer><expr> p
	  \ defx#do_action('paste')
	  nnoremap <silent><buffer><expr> l
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> E
	  \ defx#do_action('open', 'vsplit')
	  nnoremap <silent><buffer><expr> P
	  \ defx#do_action('open', 'pedit')
	  nnoremap <silent><buffer><expr> o
	  \ defx#do_action('open_or_close_tree')
	  nnoremap <silent><buffer><expr> K
	  \ defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> N
	  \ defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> M
	  \ defx#do_action('new_multiple_files')
	  nnoremap <silent><buffer><expr> C
	  \ defx#do_action('toggle_columns',
	  \                'mark:indent:icon:filename:type:size:time')
	  nnoremap <silent><buffer><expr> S
	  \ defx#do_action('toggle_sort', 'time')
	  nnoremap <silent><buffer><expr> d
	  \ defx#do_action('remove')
	  nnoremap <silent><buffer><expr> r
	  \ defx#do_action('rename')
	  nnoremap <silent><buffer><expr> !
	  \ defx#do_action('execute_command')
	  nnoremap <silent><buffer><expr> x
	  \ defx#do_action('execute_system')
	  nnoremap <silent><buffer><expr> yy
	  \ defx#do_action('yank_path')
	  nnoremap <silent><buffer><expr> .
	  \ defx#do_action('toggle_ignored_files')
	  nnoremap <silent><buffer><expr> ;
	  \ defx#do_action('repeat')
	  nnoremap <silent><buffer><expr> h
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> ~
	  \ defx#do_action('cd')
	  nnoremap <silent><buffer><expr> q
	  \ defx#do_action('quit')
	  nnoremap <silent><buffer><expr> <Space>
	  \ defx#do_action('toggle_select') . 'j'
	  nnoremap <silent><buffer><expr> *
	  \ defx#do_action('toggle_select_all')
	  nnoremap <silent><buffer><expr> j
	  \ line('.') == line('$') ? 'gg' : 'j'
	  nnoremap <silent><buffer><expr> k
	  \ line('.') == 1 ? 'G' : 'k'
	  nnoremap <silent><buffer><expr> <C-l>
	  \ defx#do_action('redraw')
	  nnoremap <silent><buffer><expr> <C-g>
	  \ defx#do_action('print')
	  nnoremap <silent><buffer><expr> cd
	  \ defx#do_action('change_vim_cwd')
	endfunction

" Denite
call denite#custom#option('_', {
		\ 'cached_filter': v:true,
		\ 'cursor_shape': v:true,
		\ 'cursor_wrap': v:true,
		\ 'highlight_filter_background': 'DeniteFilter',
		\ 'highlight_matched_char': 'Underlined',
		\ 'matchers': 'matcher/fruzzy',
		\ 'prompt': 'λ ',
		\ 'split': 'floating',
		\ 'start_filter': v:true,
		\ 'statusline': v:false,
		\ })
function! s:denite_detect_size() abort
    let s:denite_winheight = 20
    let s:denite_winrow = &lines > s:denite_winheight ? (&lines - s:denite_winheight) / 2 : 0
    let s:denite_winwidth = &columns > 240 ? &columns / 2 : 120
    let s:denite_wincol = &columns > s:denite_winwidth ? (&columns - s:denite_winwidth) / 2 : 0
    call denite#custom#option('_', {
         \ 'wincol': s:denite_wincol,
         \ 'winheight': s:denite_winheight,
         \ 'winrow': s:denite_winrow,
         \ 'winwidth': s:denite_winwidth,
         \ })
  endfunction
   augroup denite-detect-size
    autocmd!
    autocmd VimResized * call <SID>denite_detect_size()
  augroup END
  call s:denite_detect_size()


call denite#custom#option('search', { 'start_filter': 0, 'no_empty': 1 })
call denite#custom#option('list', { 'start_filter': 0 })
call denite#custom#option('jump', { 'start_filter': 0 })
call denite#custom#option('git', { 'start_filter': 0 })
call denite#custom#option('mpc', { 'winheight': 20 })

call denite#custom#source('file/rec,file_mru,file/old,buffer,directory/rec,directory_mru', 'converters', ['devicons_denite_converter'])

" MATCHERS
" Default is 'matcher/fuzzy'
call denite#custom#source('tag', 'matchers', ['matcher/substring'])
" call denite#custom#source('file/rec', 'matchers', ['matcher/fruzzy'])

if has('nvim') && &runtimepath =~# '\/cpsm'
	call denite#custom#source(
		\ 'buffer,file_mru,file/old,file/rec,grep,mpc,line,neoyank',
		\ 'matchers', ['matcher/cpsm', 'matcher/fuzzy'])
endif

" SORTERS
" Default is 'sorter/rank'
call denite#custom#source('z', 'sorters', ['sorter_z'])

" CONVERTERS
" Default is none
call denite#custom#source(
	\ 'buffer,file_mru,file/old',
	\ 'converters', ['converter_relative_word'])

" FIND and GREP COMMANDS
if executable('ag')
	" The Silver Searcher
	call denite#custom#var('file/rec', 'command',
		\ ['ag', '-U', '--hidden', '--follow', '--nocolor', '--nogroup', '-g', ''])

	" Setup ignore patterns in your .agignore file!
	" https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage

	call denite#custom#var('grep', 'command', ['ag'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', [])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
	call denite#custom#var('grep', 'default_opts',
		\ [ '--skip-vcs-ignores', '--vimgrep', '--smart-case', '--hidden' ])

elseif executable('ack')
	" Ack command
	call denite#custom#var('grep', 'command', ['ack'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', ['--match'])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
	call denite#custom#var('grep', 'default_opts',
			\ ['--ackrc', $HOME.'/.config/ackrc', '-H',
			\ '--nopager', '--nocolor', '--nogroup', '--column'])

elseif executable('rg')
	" Ripgrep
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])
endif


" KEY MAPPINGS
autocmd FileType denite call s:denite_settings()
function! s:denite_settings() abort
	highlight! link CursorLine Visual
	nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> i    denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> d    denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p    denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> st   denite#do_map('do_action', 'tabopen')
	nnoremap <silent><buffer><expr> sg   denite#do_map('do_action', 'vsplit')
	nnoremap <silent><buffer><expr> sv   denite#do_map('do_action', 'split')
	nnoremap <silent><buffer><expr> '    denite#do_map('quick_move')
	nnoremap <silent><buffer><expr> q    denite#do_map('quit')
	nnoremap <silent><buffer><expr> r    denite#do_map('redraw')
	nnoremap <silent><buffer><expr> yy   denite#do_map('do_action', 'yank')
	nnoremap <silent><buffer><expr> <Esc>   denite#do_map('quit')
	nnoremap <silent><buffer><expr> <C-u>   denite#do_map('restore_sources')
	nnoremap <silent><buffer><expr> <C-f>   denite#do_map('do_action', 'defx')
	nnoremap <silent><buffer><expr> <C-x>   denite#do_map('choose_action')
	nnoremap <silent><buffer><expr><nowait> <Space> denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_settings()
function! s:denite_filter_settings() abort
	nnoremap <silent><buffer><expr> <Esc>  denite#do_map('quit')
	" inoremap <silent><buffer><expr> <Esc>  denite#do_map('quit')
	nnoremap <silent><buffer><expr> q      denite#do_map('quit')
	imap <silent><buffer> <C-c> <Plug>(denite_filter_quit)
	"inoremap <silent><buffer><expr> <C-c>  denite#do_map('quit')
	nnoremap <silent><buffer><expr> <C-c>  denite#do_map('quit')
	inoremap <silent><buffer>       kk     <Esc><C-w>p
	nnoremap <silent><buffer>       kk     <C-w>p
	inoremap <silent><buffer>       jj     <Esc><C-w>p
	nnoremap <silent><buffer>       jj     <C-w>p
endfunction

nnoremap <silent><localLeader>da  :TodoAdd 
nnoremap <silent><LocalLeader>m :<C-u>Denite menu<CR>

noremap zl :<C-u>call <SID>my_denite_outline(&filetype)<CR>
noremap zL :<C-u>call <SID>my_denite_decls(&filetype)<CR>
noremap zT :<C-u>call <SID>my_denite_file_rec_goroot()<CR>

nnoremap <silent> <LocalLeader>gl :<C-u>Denite gitlog:all<CR>
nnoremap <silent> <LocalLeader>gh :<C-u>Denite gitbranch<CR>

function! s:my_denite_outline(filetype) abort
  execute 'Denite' a:filetype ==# 'go' ? "decls:'%:p'" : 'outline'
endfunction
function! s:my_denite_decls(filetype) abort
  if a:filetype ==# 'go'
    Denite decls
  else
    call denite#util#print_error('decls does not support filetypes except go')
  endif
endfunction
function! s:my_denite_file_rec_goroot() abort
  if !executable('go')
    call denite#util#print_error('`go` executable not found')
    return
  endif
  let out = system('go env | grep ''^GOROOT='' | cut -d\" -f2')
  let goroot = substitute(out, '\n', '', '')
  call denite#start(
        \ [{'name': 'file/rec', 'args': [goroot]}],
        \ {'input': '.go'})
endfunction


let g:indentline_enabled = 1
let g:indentline_char='┆'
let g:indentLine_fileTypeExclude = ['defx', 'denite','startify','tagbar','vista_kind']
let g:indentLine_concealcursor = 'niv'
let g:indentLine_color_term = 96
let g:indentLine_color_gui= '#725972'
let g:indentLine_showFirstIndentLevel =1
autocmd Filetype json let g:indentLine_setConceal = 0
