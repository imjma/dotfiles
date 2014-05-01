#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=$HOME/dotfiles                    # dotfiles directory
files=".bashrc .bash_profile .zshrc .gitconfig .vimrc .vim"    # list of files/folders to symlink in homedir

##########
# change to the dotfiles directory
echo "==> Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
  [[ ! -e $HOME/$file ]] && ln -s $dir/$file $HOME/$file || echo "### $file already exists..."
done

# .tmux.conf
if [[ "$(uname)" = "Linux" ]]; then
  tmuxconf=".tmux.linux.conf"
else
  tmuxconf=".tmux.conf"
fi
[[ ! -e "$HOME/.tmux.conf" ]] && ln -s $dir/$tmuxconf $HOME/.tmux.conf || echo "###
.tmux.conf already exists..."

# symbol link .oh-my-zsh custom plugins
ZSH=$HOME/.oh-my-zsh
pluginsDir=custom/plugins
plugins="zsh-syntax-highlighting"

# dotfiles oh-my-zsh plugins folder
src=$dir/.oh-my-zsh/$pluginsDir
target=$ZSH/$pluginsDir

echo "==> Symbol link oh-my-zsh plugins"

for plugin in $plugins; do
  [[ ! -e $target/$plugin ]] && ln -s $src/$plugin $target/$plugin || echo "### $plugin already exists..."
done
