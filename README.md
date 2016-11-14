# My dotfiles

## Installation

	git pull && git submodule update --init --recursive

## ZSH

- oh-my-zsh

      ln -s ~/dotfiles/zshrc-ohmyzsh ~/.zshrc

- prezto

      ln -s ~/dotfiles/zshrc-prezto ~/.zshrc

- zplug

      curl -sL zplug.sh/installer | zsh
      ln -s ~/dotfiles/zshrc-zplug ~/.zshrc

## VIM

- vim-plug

      curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## ZPLUG

- supercrabtree/k

      brew install coreutils
