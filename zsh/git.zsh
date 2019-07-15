# Makes git auto completion faster favouring for local completions
__git_files () {
    _wanted files expl 'local files' _files
}

gdv() { git diff -w "$@" | view - }
# Aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gau='git add -u'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gc='git commit -v'
alias gcam='git commit --amend --reuse-message HEAD'
alias gamend='git commit --amend --reuse-message HEAD'
alias gcd="git checkout develop"
alias gclean='git reset --hard && git clean -dfx'
alias gcm='git checkout master'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdt='git difftool'
alias gf='git fetch'
alias gfo='git fetch origin'
alias gl='git pull'
alias gm='git merge'
alias gp='git push'
alias gr='git remote'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grset='git remote set-url'
alias grup='git remote update'
alias grv='git remote -v'
alias gss='git status -s'
alias gssu='git status -uno'
alias gst='git status'
alias gstp='git stash pop'
alias grrm='git remote remove'
alias gup='git pull --rebase'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'
alias gnah="git reset --hard;git clean -df"

#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

# these aliases take advantage of the previous function
alias gfpush='git push -f origin $(current_branch)'
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
alias ggpull='git pull origin $(current_branch)'
alias ggpur='git pull --rebase origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias ggsup='git branch --set-upstream-to=origin/$(current_branch)'
alias gpsup='git push --set-upstream origin $(current_branch)'

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
alias glp="_git_log_prettily"
