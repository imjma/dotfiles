################################################################################
# Alias
################################################################################
# alias gci="git commit -a -m"

if [[ `command -v nvim` > /dev/null ]]; then
  # alias vim="mvim -v"
  # alias vim="nvim"
  alias v="nvim"
fi
# git
alias nah="git reset --hard;git clean -df"
alias wip="git add . && git commit -m 'wip'"

# copy directory
alias cpd="cp -avR"
alias copy="rsync -avv --stats --human-readable --itemize-changes --progress --partial"

# search text
alias grepcur="grep -rnw . -e"

# vagrant
alias vup="vagrant up"
alias vdown="vagrant halt"
alias vssh="vagrant ssh"
alias vgo="vagrant up & vagrant ssh"

# php
alias p="vendor/bin/phpunit"
alias pf="vendor/bin/phpunit --filter"

# composer
alias c="composer"
alias cu='composer update'
alias ci='composer install'
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
