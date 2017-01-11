#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=$HOME/dotfiles                    # dotfiles directory
# files=".bashrc .bash_profile .zshrc .gitconfig .vimrc .vim .tmux.conf .tigrc"    # list of files/folders to symlink in homedir
files="gitconfig vimrc vim tmux.conf tigrc irbrc"    # list of files/folders to symlink in homedir

##########
# change to the dotfiles directory
echo "==> Changing to the $dir directory"
cd $dir
echo "...done"

echo "==> init submodule"
git submodule update --init --recursive
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
  [[ ! -e $HOME/$file ]] && ln -s $dir/$file $HOME/.$file || echo "### .$file already exists..."
done

# symbol link .oh-my-zsh custom plugins
# ZSH=$HOME/.oh-my-zsh
# pluginsDir=custom/plugins
# plugins="zsh-syntax-highlighting"

# dotfiles oh-my-zsh plugins folder
# src=$dir/.oh-my-zsh/$pluginsDir
# target=$ZSH/$pluginsDir

# echo "==> Symbol link oh-my-zsh plugins"

# for plugin in $plugins; do
#   [[ ! -e $target/$plugin ]] && ln -s $src/$plugin $target/$plugin || echo "### $plugin already exists..."
# done

##########
# zim
# symbol link
# ln -s $dir/zsh/zim $HOME/.zim
# ln -s $dir/zsh/zimrc $HOME/.zimrc

##########
# zplug
export ZPLUG_HOME=$HOME/.zplug
ln -s $dir/zshrc-zplug $HOME/.zshrc
ln -s $dir/dotfiles/zsh/zplug/ $HOME/.zplug
