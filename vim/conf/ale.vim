" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

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

