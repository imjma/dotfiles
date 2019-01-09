# =============
# INIT
# =============

# Senstive functions which are not pushed to Github
# It contains GOPATH, some functions, aliases etc...
[ -r ~/.zsh_private ] && source ~/.zsh_private

# =============
#    ALIAS
# =============
alias ..='cd ..'
alias ...='cd ../..'

alias t="tig status"
alias tigs="tig status" #old habits don't die
alias d='git diff' 

case `uname` in
  Darwin)
    alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say cache flushed'
    alias ls='ls -GpF' # Mac OSX specific
    alias ll='ls -alGpF' # Mac OSX specific
  ;;
  Linux)
    alias ll='ls -al'
    alias ls='ls --color=auto' 
  ;;
esac

[[ -e $HOME/dotfiles/zsh/alias.zsh ]] && source $HOME/dotfiles/zsh/alias.zsh
[[ -e $HOME/dotfiles/zsh/git.zsh ]] && source $HOME/dotfiles/zsh/git.zsh
[[ -e $HOME/dotfiles/zsh/brew.zsh ]] && source $HOME/dotfiles/zsh/brew.zsh

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# =============
#    EXPORT
# =============
export PATH="/usr/local/go/bin:$GOBIN:$HOME/.cargo/bin:$PATH"

export EDITOR="neovim"
export LSCOLORS=cxBxhxDxfxhxhxhxhxcxcx
export CLICOLOR=1

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# =============
#    PROMPT
# =============
# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# =============
#    HISTORY
# =============

## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
# ignore duplication command history list
setopt hist_ignore_dups 
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
# share command history data
setopt share_history 

# ===================
#    MISC SETTINGS
# ===================

# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

# only exit if we're not on the last pane
exit() {
  if [[ -z $TMUX ]]; then
    builtin exit
    return
  fi

  panes=$(tmux list-panes | wc -l)
  wins=$(tmux list-windows | wc -l) 
  count=$(($panes + $wins - 1))
  if [ $count -eq 1 ]; then
    tmux detach
  else
    builtin exit
  fi
}

# ===================
#    PLUGINS
# ===================

case `uname` in
  Darwin)
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  ;;
  Linux)
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  ;;
esac

# https://github.com/gsamokovarov/jump
eval "$(jump shell)"
