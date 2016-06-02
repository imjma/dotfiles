"===============================================================================
" ctrlp
"===============================================================================

" We don't want to use Ctrl-p as the mapping because
" it interferes with YankRing (paste, then hit ctrl-p)
" let g:ctrlp_map = '<c-p>'
let g:ctrlp_map = ',t'

" let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_height = 30
let g:ctrlp_match_window = 'order:ttb,max:20'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/var/*,*/vendor/*

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  " set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore .svn
        \ --ignore .hg
        \ --ignore .DS_Store
        \ --ignore "**/*.pyc"
        \ -g ""'

  let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")':   ['<c-n>'],
    \ 'PrtSelectMove("k")':   ['<c-p>'],
    \ 'PrtHistory(-1)':       ['<down>'],
    \ 'PrtHistory(1)':        ['<up>'],
    \}

    " ag is fast enough that CtrlP doesn't need to cache
      " let g:ctrlp_use_caching = 0
else
    " Fall back to using git ls-files if Ag is not available
    " let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
      " let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Default to filename searches - so that appctrl will find application
" controller
" let g:ctrlp_by_filename = 1


nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
