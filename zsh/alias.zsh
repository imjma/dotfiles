################################################################################
# Alias
################################################################################
# alias gci="git commit -a -m"

if [[ `command -v nvim` > /dev/null ]]; then
  # alias vim="mvim -v"
  # alias vim="nvim"
  alias v="nvim"
else
  alias v="vim"
fi
# git
# alias nah="git reset --hard;git clean -df"
# alias wip="git add . && git commit -m 'wip'"

# copy directory
alias cpd="cp -avR"
alias copy="rsync -avv --stats --human-readable --itemize-changes --progress --partial"

# vagrant
alias vup="vagrant up"
alias vdown="vagrant halt"
alias vssh="vagrant ssh"
alias vus="vagrant up & vagrant ssh"

# php
alias p="vendor/bin/phpunit"
alias pf="vendor/bin/phpunit --filter"

# composer
alias c="composer"
alias cu='composer update'
alias ci='composer install'
alias cr='composer require'
alias cda='composer dump-autoload -o'

# laravel
alias art="php artisan"
alias tinker="php artisan tinker"
alias laravel-create="composer create-project --prefer-dist laravel/laravel"

# osx
alias finder="open -a 'Finder' ."

# functionns
mkcdir () {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# from: http://stackoverflow.com/a/12495234/4921402
alias gcfa="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} fetch \;"

# override prezto ultity alias with exa
# https://the.exa.website
alias l='exa -a'
alias ll='exa -lgh'        # Lists human readable sizes.
alias lt='exa --long --tree'
alias la='exa -lagh'
alias lg='exa -lagh --git'

alias tmd='tmux attach -t dev || tmux new -ADs dev'

# Markdown files
alias -s md=v

# Docker
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'
