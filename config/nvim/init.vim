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
" if has('nvim')
"   Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/defx.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" Plug 'vifm/vifm.vim'
Plug 'mcchrish/nnn.vim'
" Plug 'fatih/molokai'
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'psliwka/vim-smoothie'
Plug 'ryanoasis/vim-devicons'
" Plug 'kristijanhusak/defx-icons'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'

Plug 'wellle/targets.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'Raimondi/delimitMate'

Plug 'fatih/vim-go'
Plug 'jparise/vim-graphql'
Plug 'liuchengxu/vista.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'

" Plug 'camspiers/animate.vim'
" Plug 'camspiers/lens.vim'

" Initialize plugin system
call plug#end()

" Required:
filetype plugin indent on
syntax enable

let g:coc_global_extensions = ['coc-git', 'coc-lists', 'coc-json', 'coc-yaml', 'coc-snippets']

" set t_Co=256
set background=dark
" colorscheme molokai
colorscheme gruvbox

" Default show linenumber
if !exists('g:noshowlinenumber')
    let g:noshowlinenumber = 0
endif
if (g:noshowlinenumber == 1)
    set nonumber norelativenumber
else
    set number relativenumber
endif

" general
set autoindent
set autoread
set backspace=indent,eol,start
set clipboard=unnamed
set cmdheight=2 " Better display for messages
set cursorline              " highlight current line
hi clear CursorLine
hi CursorLine gui=underline cterm=underline
set expandtab
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " 10 nested fold max
set hlsearch            " highlight matches
set ignorecase          " case insensitive
set laststatus=2
set lazyredraw
set list
set listchars=tab:¦\ ,trail:⋅,extends:»,precedes:«,nbsp:␣
set nobackup
set nofoldenable
set noshowmode
set noswapfile
" set nowrap
set nowritebackup
set ruler
" set rulerformat=%60(%=%m\ %#Identifier#%t\ %#Label#%{gitbranch#name()}%#Normal#\ %l:%c\ `%#Identifier#o%#Normal#´%)
set scrolloff=10             " at least 5 visible lines of text above and below
set shortmess+=c " don't give |ins-completion-menu| messages.
" set showtabline=2
set signcolumn=yes " always show signcolumns
set smartindent
set splitbelow " Open split panes to bottom
set splitright " Open split panes to right
set updatetime=300 " You will have bad coc experience for diagnostic messages when it's default 4000.
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
set wildmode=list:longest,full " List all options and complete

" I dislike visual bell as well.
set novisualbell

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

" key mappings
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
" nnoremap space> za
nnoremap z] zo]z
nnoremap z[ zo[z<Paste>

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

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
nnoremap <silent> <leader>cf :let @* = expand("%:~")<CR>
nnoremap <silent> <leader>cn :let @* = expand("%:t")<CR>

" These mappings will make it so that going to the next one in a search will
" center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" coc

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <silent> <space>k :call CocAction('format')<CR>

" coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

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

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>

" coc-lists
nmap <silent> <leader>p :CocList files<CR>
nmap <silent> <leader><CR> :CocList buffers<CR>
nmap <silent> <leader>w :exe 'CocList -I --normal -nmap <space>/ :CocList grep<space>-input='.expand('<cword>').' words'<CR>
nmap <leader>/ :CocList grep<space>

" coc-git
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
" nmap gs <Plug>(coc-git-chunkinfo)
" nmap gc <Plug>(coc-git-commit)
" show commit contains current position

" defx

" nnoremap <silent> <Leader>e
"                 \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
" nnoremap <silent> <Leader>E
"                 \ :<C-u>Defx -search=`expand('%:p')` -buffer-name=tab`tabpagenr()`<CR>

" call defx#custom#option('_', {
" 	\ 'columns': 'icons:indent:git:filename:type',
" 	\ 'winwidth': 30,
" 	\ 'split': 'vertical',
" 	\ 'direction': 'topleft',
" 	\ 'show_ignored_files': 0,
" 	\ 'toggle': 1,
" 	\ 'resume': 1,
" 	\ 'buffer_name': 'defxplorer',
" 	\ })

" autocmd FileType defx call s:defx_my_settings()
" 	function! s:defx_my_settings() abort
" 	  " Define mappings
" 	  nnoremap <silent><buffer><expr> <CR>
" 	  \ defx#do_action('open')
" 	  nnoremap <silent><buffer><expr> c
" 	  \ defx#do_action('copy')
" 	  nnoremap <silent><buffer><expr> m
" 	  \ defx#do_action('move')
" 	  nnoremap <silent><buffer><expr> p
" 	  \ defx#do_action('paste')
" 	  nnoremap <silent><buffer><expr> l
" 	  \ defx#do_action('open')
" 	  nnoremap <silent><buffer><expr> <C-v>
" 	  \ defx#do_action('open', 'vsplit')
" 	  nnoremap <silent><buffer><expr> P
" 	  \ defx#do_action('open', 'pedit')
" 	  nnoremap <silent><buffer><expr> o
" 	  \ defx#do_action('open_or_close_tree')
" 	  nnoremap <silent><buffer><expr> K
" 	  \ defx#do_action('new_directory')
" 	  nnoremap <silent><buffer><expr> N
" 	  \ defx#do_action('new_file')
" 	  nnoremap <silent><buffer><expr> M
" 	  \ defx#do_action('new_multiple_files')
" 	  nnoremap <silent><buffer><expr> C
" 	  \ defx#do_action('toggle_columns',
" 	  \                'mark:indent:icon:filename:type:size:time')
" 	  nnoremap <silent><buffer><expr> S
" 	  \ defx#do_action('toggle_sort', 'time')
" 	  nnoremap <silent><buffer><expr> d
" 	  \ defx#do_action('remove')
" 	  nnoremap <silent><buffer><expr> r
" 	  \ defx#do_action('rename')
" 	  nnoremap <silent><buffer><expr> !
" 	  \ defx#do_action('execute_command')
" 	  nnoremap <silent><buffer><expr> x
" 	  \ defx#do_action('execute_system')
" 	  nnoremap <silent><buffer><expr> yy
" 	  \ defx#do_action('yank_path')
" 	  nnoremap <silent><buffer><expr> .
" 	  \ defx#do_action('toggle_ignored_files')
" 	  nnoremap <silent><buffer><expr> ;
" 	  \ defx#do_action('repeat')
" 	  nnoremap <silent><buffer><expr> h
" 	  \ defx#do_action('cd', ['..'])
" 	  nnoremap <silent><buffer><expr> ~
" 	  \ defx#do_action('cd')
" 	  nnoremap <silent><buffer><expr> q
" 	  \ defx#do_action('quit')
" 	  nnoremap <silent><buffer><expr> <Space>
" 	  \ defx#do_action('toggle_select') . 'j'
" 	  nnoremap <silent><buffer><expr> *
" 	  \ defx#do_action('toggle_select_all')
" 	  nnoremap <silent><buffer><expr> j
" 	  \ line('.') == line('$') ? 'gg' : 'j'
" 	  nnoremap <silent><buffer><expr> k
" 	  \ line('.') == 1 ? 'G' : 'k'
" 	  nnoremap <silent><buffer><expr> <C-l>
" 	  \ defx#do_action('redraw')
" 	  nnoremap <silent><buffer><expr> <C-g>
" 	  \ defx#do_action('print')
" 	  nnoremap <silent><buffer><expr> cd
" 	  \ defx#do_action('change_vim_cwd')
" 	endfunction

" for go
" autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

let g:indentline_enabled = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['denite', 'startify', 'tagbar', 'vista_kind']
let g:indentLine_concealcursor = 'niv'
let g:indentLine_color_term = 96
let g:indentLine_color_gui= '#725972'
let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_leadingSpaceEnabled = 1
autocmd Filetype json let g:indentLine_setConceal = 0

" vim-indent-guides
" let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=238
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" vista.vim
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

nmap <leader>t :Vista!!<CR>
let g:vista_executive_for = {
      \ 'go': 'coc',
      \ }
nnoremap <silent><leader>vf :Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_width = 50

" let g:lens#disabled_filetypes = ['nerdtree', 'fzf']
" let g:lens#animate = 0

" Lens {{{
" let g:lens#height_resize_min = 15
" }}}

" nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
" nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
" nnoremap <silent> <Left>  :call animate#window_delta_width(10)<CR>
" nnoremap <silent> <Right> :call animate#window_delta_width(-10)<CR>

" ==================== Fugitive ====================
vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gb :Gblame<CR>

" ==================== nnn ====================
" Disable default mappings
let g:nnn#set_default_mappings = 0

" Then set your own
nnoremap <silent> <leader>nn :NnnPicker<CR>

" Or override
" Start nnn in the current file's directory
nnoremap <leader>n :NnnPicker '%:p:h'<CR>

" Floating window (neovim latest and vim with patch 8.2.191)
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }

let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

" lightline.vim

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


" https://github.com/fatih/dotfiles/blob/master/vimrc
" ==================== vim-go ====================
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }

let g:go_test_prepend_name = 1
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_auto_sameids = 0

let g:go_null_module_warning = 0
let g:go_echo_command_info = 1

let g:go_autodetect_gopath = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint']

let g:go_info_mode = 'gopls'
let g:go_rename_command='gopls'
let g:go_gopls_complete_unimported = 1
let g:go_implements_mode='gopls'
let g:go_diagnostics_enabled = 1
let g:go_doc_popup_window = 1

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 0
let g:go_highlight_operators = 1
let g:go_highlight_format_strings = 0
let g:go_highlight_function_calls = 0
let g:go_gocode_propose_source = 1

let g:go_modifytags_transform = 'camelcase'
let g:go_fold_enable = []

nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>


" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction


augroup go
  autocmd!

  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def)
  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
  " autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)

  autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

  " autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
  " autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>r  <Plug>(go-referrers)
  " autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
  " autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)

  " autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)

  " I like these more!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" ==================== FZF ====================
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

" ==================== delimitMate ====================
let g:delimitMate_expand_cr = 1   
let g:delimitMate_expand_space = 1    
let g:delimitMate_smart_quotes = 1    
let g:delimitMate_expand_inside_quotes = 0    
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'   

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
