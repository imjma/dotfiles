#/bin/bash

# HOMEBREW
function installBREW() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# ZSH
function installZSH() {
    brew install zsh
}

# NVM
function installNVM() {
    brew install nvm
}

# YARN
function installYARN() {
    brew install yarn
}

# GPG
function installGPG() {
    brew install gnupg
    brew install pinentry-mac
}

# Install Brew if not found
command -v brew >/dev/null 2>&1 || installBREW()

# Install ZSH if not found
command -v zsh >/dev/null 2>&1 || installZSH()

# Install NVM
command -v nvm >/dev/null 2>&1 || installNVM()

# Install Yarn
command -v yarn >/dev/null 2>&1 || installYARN()

# Install GPG
command -v gpg >/dev/null 2>&1 || installGPG()

#.zshrc
ln -s ~/dotfiles/zshrc.prezto ~/.zshrc
