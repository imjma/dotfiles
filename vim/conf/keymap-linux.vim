" ========================================
" Mac specific General vim sanity improvements
" ========================================

" Alt-/ to toggle comments
map <A-/> :TComment<CR>
imap <A-/> <Esc>:TComment<CR>i

" Resize windows with arrow keys
nnoremap <C-Up> <C-w>+
nnoremap <C-Down> <C-w>-
nnoremap <C-Left> <C-w><
nnoremap <C-Right>  <C-w>>

" ============================
" Tabularize - alignment
" ============================
" Hit Alt-Shift-A then type a character you want to align by
nmap <A-A> :Tabularize /
vmap <A-A> :Tabularize /