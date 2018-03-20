" =============================================================================
" Language: Golang {{{
" =============================================================================

au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

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
