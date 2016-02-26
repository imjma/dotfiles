"-------------------------------------------------------------------------------
" Settings
"-------------------------------------------------------------------------------
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

"-------------------------------------------------------------------------------
" functions
"-------------------------------------------------------------------------------
"-------------------------------------------------------------------------------
" Keybindings
"-------------------------------------------------------------------------------
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
