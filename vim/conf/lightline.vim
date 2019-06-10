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

