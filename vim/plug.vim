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
Plug 'NLKNguyen/papercolor-theme'

" Vim only plugins
if !has('nvim')
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}  " Needed to make sebdah/vim-delve work on Vim
    Plug 'Shougo/vimshell.vim'                  " Needed to make sebdah/vim-delve work on Vim
endif

" Language
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'

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

" Go
Plug 'sebdah/vim-delve'

" Language support
Plug 'StanAngeloff/php.vim'                    " PHP syntax highlighting
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'} " PHP auto completion
Plug 'aklt/plantuml-syntax'                    " PlantUML syntax highlighting
Plug 'cespare/vim-toml'                        " toml syntax highlighting
Plug 'chr4/nginx.vim'                          " nginx syntax highlighting
Plug 'dag/vim-fish'                            " Fish syntax highlighting
Plug 'digitaltoad/vim-pug'                     " Pug syntax highlighting
Plug 'fatih/vim-go'                            " Go support
Plug 'fishbullet/deoplete-ruby'                " Ruby auto completion
Plug 'hashivim/vim-terraform'                  " Terraform syntax highlighting
Plug 'kchmck/vim-coffee-script'                " CoffeeScript syntax highlighting
Plug 'kylef/apiblueprint.vim'                  " API Blueprint syntax highlighting
Plug 'leafgarland/typescript-vim'              " TypeScript syntax highlighting
Plug 'lifepillar/pgsql.vim'                    " PostgreSQL syntax highlighting
Plug 'mxw/vim-jsx'                             " JSX syntax highlighting
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' } " Go auto completion
Plug 'pangloss/vim-javascript'                 " JavaScript syntax highlighting
Plug 'plasticboy/vim-markdown'                 " Markdown syntax highlighting
Plug 'rodjek/vim-puppet'                       " Puppet syntax highlighting
Plug 'tclh123/vim-thrift'                      " Thrift syntax highlighting
Plug 'zchee/deoplete-go', { 'do': 'make'}      " Go auto completion
Plug 'zchee/deoplete-jedi'                     " Go auto completion

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
