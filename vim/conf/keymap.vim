"===============================================================================
" Command-line Mode Key Mappings
"===============================================================================

" w!!: Writes using sudo
cnoremap w!! w !sudo tee % >/dev/null

"===============================================================================
" Normal Mode Shift Key Mappings
"===============================================================================

" Shift-Tab: NERDTree
" nnoremap <silent> <S-Tab> :NERDTreeToggle<CR>

" keyboard shortcuts
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>l :Align
nnoremap <leader>a :Ag<space>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>\ :TagbarToggle<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <leader>c <Plug>Kwbd
noremap <silent> <leader><leader>v :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" space open/closes folds
nnoremap <space> za

" Q: Closes the window
" nnoremap Q :q<cr>

" W: Save
nnoremap W :w<cr>

" ========================================
" General vim sanity improvements
" ========================================
" map semicolon to colon to avoid the extra shift keypress
nmap ;; :
imap ii <Esc>

"
" alias yw to yank the entire word 'yank inner word'
" even if the cursor is halfway inside the word
" FIXME: will not properly repeat when you use a dot (tie into repeat.vim)
nnoremap <leader>yw yiww

" ,ow = 'overwrite word', replace a word with what's in the yank buffer
" FIXME: will not properly repeat when you use a dot (tie into repeat.vim)
nnoremap <leader>ow "_diwhp

"make Y consistent with C and D
nnoremap Y y$
function! YRRunAfterMaps()
  nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction

" Make 0 go to the first character rather than the beginning
" of the line. When we're programming, we're almost always
" interested in working with text rather than empty space. If
" you want the traditional beginning of line, use ^
nnoremap 0 ^
nnoremap ^ 0

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
" The difference is in whether a space is put in
map <leader>( ysiw(
map <leader>) ysiw)
vmap <leader>( c( <C-R>" )<ESC>
vmap <leader>) c(<C-R>")<ESC>

" ,[ Surround a word with [brackets]
map <leader>] ysiw]
map <leader>[ ysiw[
vmap <leader>[ c[ <C-R>" ]<ESC>
vmap <leader>] c[<C-R>"]<ESC>

" ,{ Surround a word with {braces}
map <leader>} ysiw}
map <leader>{ ysiw{
vmap <leader>} c{ <C-R>" }<ESC>
vmap <leader>{ c{<C-R>"}<ESC>

map <leader>` ysiw`

" gary bernhardt's hashrocket
imap <c-l> <space>=><space>

"Go to last edit location with ,.
nnoremap <leader>. '.

"When typing a string, your quotes auto complete. Move past the quote
"while still in insert mode by hitting Ctrl-a. Example:
"
" type 'foo<c-a>
"
" the first quote will autoclose so you'll get 'foo' and hitting <c-a> will
" put the cursor right after the quote
imap <C-a> <esc>wa

"Move back and forth through previous and next buffers
"with ,z and ,x
nnoremap <silent> <leader>z :bp<CR>
nnoremap <silent> <leader>x :bn<CR>

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

" ============================
" Intelligent Window Killer
" ============================

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

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at 
nnoremap <silent> <leader>cf :let @* = expand("%:~")<CR>
nnoremap <silent> <leader>cn :let @* = expand("%:t")<CR>

" linenumber {{{

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
