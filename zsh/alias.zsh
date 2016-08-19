################################################################################
# Alias 
################################################################################
# alias gci="git commit -a -m"

if [[ `uname` = 'Darwin' ]] && [[ `command -v vim` > /dev/null ]]; then
  # alias vim="mvim -v"
  # alias vim="nvim"
  alias v="nvim"
fi

# copy directory
alias cpd="cp -avR"
