if &compatible
  set nocompatible               " Be iMproved
endif

" Skip vim plugins {{{
let g:loaded_rrhelper = 1
" Skip loading menu.vim, saves ~100ms
let g:did_install_default_menus = 1
" }}}

" Python {{{
" This must be here becasue it makes loading vim VERY SLOW otherwise
if has('nvim')
  let g:python_host_skip_check = 1
  let g:python3_host_skip_check = 1
  if executable('python2')
    let g:python_host_prog = exepath('python2')
  endif
  if executable('python3')
    let g:python3_host_prog = exepath('python3')
  endif
endif
" }}}

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
if has('nvim')
  call plug#begin(stdpath('data') . '/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'itchyny/lightline.vim'
Plug 'jparise/vim-graphql'
Plug 'tridactyl/vim-tridactyl'
Plug 'sheerun/vim-polyglot'
Plug 'beauwilliams/focus.nvim'
Plug 'danilamihailov/beacon.nvim'

" Initialize plugin system
call plug#end()

" Required:
filetype plugin indent on
syntax enable

" basic {{{
set encoding=utf-8

set clipboard=unnamed
set cmdheight=2 " Better display for messages
set cursorline              " highlight current line
set display+=lastline "When 'wrap' is on, display last line even if it doesn't fit.
set foldmethod=indent
set foldnestmax=3
set guicursor=          " avoid neovim to change cursor style
set hidden "Hide buffers instead of asking if to save them
set history=1000
set hlsearch            " highlight matches
set ignorecase          " case insensitive
set laststatus=2
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
hi clear CursorLine
hi CursorLine gui=underline cterm=underline
set nofoldenable
set nomodeline
set noshowmode
set noswapfile
set nowritebackup
set ruler
set scrolloff=10             " at least 5 visible lines of text above and below
set sidescroll=1
set sidescrolloff=15 "Keep 15 columns next to the cursor when scrolling horizontally
set signcolumn=yes " always show signcolumns
set smartcase
set smarttab
set splitbelow " Open split panes to bottom
set splitright " Open split panes to right
set updatetime=300 " You will have bad coc experience for diagnostic messages when it's default 4000.
set wildmode=longest,full
set wildignore+=*.gem
set wildignore+=*.git*
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*DS_Store*
set wildignore+=*node_modules*
set wildignore+=*sass-cache*
set wildignore+=*vim/backups*
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=vendor/cache/**
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing
set wildmenu                " visual autocomplete for command menu

set tabstop=2
set shiftwidth=2
set expandtab

set autoread
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" I dislike visual bell as well.
set novisualbell

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

" Default show linenumber
if !exists('g:noshowlinenumber')
    let g:noshowlinenumber = 0
endif
if (g:noshowlinenumber == 1)
    set nonumber norelativenumber
else
    set number relativenumber
endif

set background=dark
colorscheme gruvbox
autocmd ColorScheme * highlight CocErrorFloat guifg=#ffffff
autocmd ColorScheme * highlight CocInfoFloat guifg=#ffffff
autocmd ColorScheme * highlight CocWarningFloat guifg=#ffffff
autocmd ColorScheme * highlight SignColumn guibg=#adadad

" Special sets for different filetype
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php,go,lua setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml,tpl setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120

" }}}

" key mappings {{{
let mapleader="\<Space>"

" Toggle showing linenumber
" nnoremap <silent> <leader>n :call ToggleShowlinenum()<CR>
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

"Move back and forth through previous and next buffers
"with ,z and ,x
nnoremap <silent> <leader>z :bp<CR>
nnoremap <silent> <leader>x :bn<CR>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Exit on j
imap jj <Esc>

" map semicolon to colon to avoid the extra shift keypress
nmap ;; :

" turn off search highlight
nnoremap <silent> // :nohlsearch<CR>

" Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" space open/closes folds
nnoremap z] zo]z
nnoremap z[ zo[z<Paste>

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v

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

"Go to last edit location with ,.
nnoremap <leader>. '.

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
" nnoremap <silent> <leader>cf :let @* = expand("%:~")<CR>
" nnoremap <silent> <leader>cn :let @* = expand("%:t")<CR>

" These mappings will make it so that going to the next one in a search will
" center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Makes Vim's visual mode more consistent with tmux's
vnoremap <Enter> y

" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/ {{{
" Automatically jump to end of text you pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Copy & paste to system clipboard with <Space>p and <Space>y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Quickly select text you just pasted
noremap gV `[v`]

" Stop that stupid window from popping up
map q: :q

nnoremap H 0
nnoremap L $

nnoremap Y y$
" }}}

" coc {{{
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <Leader>d <Plug>(coc-definition)
nmap <silent> <Leader>r <Plug>(coc-references)
nmap <silent> <Leader>y <Plug>(coc-type-definition)
nmap <silent> <Leader>i <Plug>(coc-implementation)
nmap <silent> <Leader>l <Plug>(coc-declaration) 

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
vmap <leader>f  <Plug>(coc-format-selected)
" nmap <silent> <space>k :call CocAction('format')<CR>

" Show all diagnostics
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>

" coc-lists
nmap <silent> <C-p> :CocList files<CR>
nmap <silent> <leader>b :CocList buffers<CR>
nnoremap <silent> <leader>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
nmap <leader>/ :CocList grep<space>
nmap <leader>// :CocListResume<CR>

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

" coc-git {{{
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
" nmap gc <Plug>(coc-git-commit)
" }}}

" coc-go {{{
" Add missing imports on save
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.go :GoFmt
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
" autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
" autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>
" }}}

" coc-explorer {{{
nmap <leader>e :CocCommand explorer<CR>

let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

" Use preset argument to open it
" nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>

" List all presets
nmap <space>el :CocList explPresets<CR>

" hook for explorer window initialized
function! CocExplorerInited(filetype, bufnr)
  " transparent
  call setbufvar(a:bufnr, '&winblend', 10)
endfunction

" }}}

" }}}

" vim-go {{{
nmap <C-g> :GoDecls<cr>

augroup go
  autocmd!

  autocmd FileType go nmap <silent> <Leader>f :GoFmt<CR>
  " autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def)
  " autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  " autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
"   " autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)

"   autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <silent> <leader>ii <Plug>(go-implements)
"   autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

"   " autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
"   " autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
"   autocmd FileType go nmap <silent> <leader>r  <Plug>(go-referrers)
"   " autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
"   " autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)

"   " autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <silent> <Leader>cc <Plug>(go-callers)

"   " I like these more!
"   autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
"   autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
"   autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
"   autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" }}}

" }}}

" coc {{{
let g:coc_global_extensions = [
  \ 'coc-explorer',
  \ 'coc-go',
  \ 'coc-git',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-yaml',
  \'coc-prettier',
  \'coc-snippets',
  \ ]

" let g:coc_auto_open = 0 " do not open quickfix automatically

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" }}}

" vim-go {{{
" " disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0

" let g:go_jump_to_error = 1
let g:go_fmt_autosave = 0
" let g:go_gopls_enabled = 0

let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_types = 1

let g:go_addtags_transform = 'camelcase'
let g:go_fold_enable = []

" }}}
" fzf {{{
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~20%' }

" search 
" nmap <C-p> :FzfHistory<cr>
" imap <C-p> <esc>:<C-u>FzfHistory<cr>

" search across files in the current directory
" nmap <C-b> :FzfFiles<cr>
" imap <C-b> <esc>:<C-u>FzfFiles<cr>

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" }}}
" lightline {{{
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
	\ 'colorscheme': 'molokai',
	\ 'active': {
		\   'left': [['mode', 'paste'], ['gitbranch', 'cocstatus', 'currentfunction', 'filename', 'modified', 'method']],
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
	\ 'component_function': {
		\  'cocstatus': 'coc#status',
		\  'currentfunction': 'CocCurrentFunction',
		\  'method': 'NearestMethodOrFunction',
		\  'gitbranch': 'FugitiveHead',
		\  'filename': 'LightlineFilename'
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

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

augroup _lightline
  autocmd!
  autocmd User ALELint call s:MaybeUpdateLightline()
  autocmd ColorScheme * call s:UpdateLightlineColorScheme()
augroup END

" }}}

" focus.nvim{{{
lua require("focus").setup()
" }}}

" beaconvim{{{
let g:beacon_ignore_filetypes = ['fzf']
let g:beacon_show_jumps = 0
nmap n n:Beacon<cr>
nmap N N:Beacon<cr>
nmap * *:Beacon<cr>
nmap # #:Beacon<cr>
augroup MyCursorLineGroup
    autocmd!
    au WinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup end
" }}}

" runtime! init.d/*.vim
"
