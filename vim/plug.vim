" vim-plug
call plug#begin('~/.vim/plugged')

"Plugin list ------------------------------------------------------------------

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

" Ctrl-P - Fuzzy file search
" Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'

" Status bar mods
Plug 'bling/vim-airline'

" Git
Plug 'airblade/vim-gitgutter'

" Interface
Plug 'christoomey/vim-tmux-navigator'

" Colorscheme
Plug 'altercation/vim-colors-solarized'
Plug 'sts10/vim-mustard'
Plug 'junegunn/seoul256.vim'
Plug 'ajh17/Spacegray.vim'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

" Language
" Plug 'vim-syntastic/syntastic'
Plug 'Shougo/neocomplete.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'w0rp/ale'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'

" Coffeescript
Plug 'kchmck/vim-coffee-script'

" Enhance
" Plug 'godlygeek/tabular'
Plug 'matze/vim-move'
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'

" Navigation
Plug 'easymotion/vim-easymotion'
Plug 'zhaocai/GoldenView.Vim'
" Plug 'scrooloose/nerdtree'
Plug 'Shougo/vimfiler.vim'

" Add plugins to &runtimepath
call plug#end()
