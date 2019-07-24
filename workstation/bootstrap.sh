#!/bin/bash

# Add third party repositories
sudo add-apt-repository ppa:keithw/mosh-dev -y
sudo add-apt-repository ppa:jonathonf/vim -y
sudo add-apt-repository ppa:neovim-ppa/stable -y

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -qq \
  build-essential \
  curl \
  git \
  gnupg \
  gnupg2 \
  htop \
  mosh \
  neovim \
  python-dev \
  python-pip \
  python3-dev \
  python3-pip \
  python3-setuptools \
  ripgrep \
  silversearcher-ag \
  software-properties-common \
  tig \
  tmux \
  unzip \
  wget \
  zsh \
  --no-install-recommends \

rm -rf /var/lib/apt/lists/*

# install Go
if ! [ -x "$(command -v go)" ]; then
  export GO_VERSION="1.12.7"
  echo " ==> Installing go ${GO_VERSION}"
  wget "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" 
  tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz" 
  rm -f "go${GO_VERSION}.linux-amd64.tar.gz"
  export PATH="/usr/local/go/bin:$PATH"
fi

# install nodejs
if ! [ -x "$(command -v node)" ]; then
  echo " ==> Installing nodejs"
  curl -sL install-node.now.sh/lts | bash -s -- -y
fi

# install zsh plugins
if [ ! -d "${HOME}/.zsh" ]; then
  echo " ==> Installing zsh plugins"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${HOME}/.zsh/zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-autosuggestions "${HOME}/.zsh/zsh-autosuggestions"

  echo " ==> Installing zsh theme"
  git clone https://github.com/denysdovhan/spaceship-prompt.git "${HOME}/.zsh/spaceship-prompt"
  ln -sfn "${HOME}/.zsh/spaceship-prompt/spaceship.zsh" "/usr/local/share/zsh/site-functions/prompt_spaceship_setup"

  # https://github.com/gsamokovarov/jump
  echo " ==> Installing jump plugins"
  wget https://github.com/gsamokovarov/jump/releases/download/v0.23.0/jump_0.23.0_amd64.deb
  sudo dpkg -i jump_0.23.0_amd64.deb
fi

echo "==> Setting shell to zsh..."
chsh -s /usr/bin/zsh

# install dotfiles
if [ ! -d /root/dotfiles ]; then
  echo "==> Setting up dotfiles"
  cd "/root"
  git clone https://github.com/0xApe/dotfiles.git
  
  cd "/root/dotfiles"

  ln -sfn $(pwd)/vimrc "${HOME}/.vimrc"
  ln -sfn $(pwd)/vim "${HOME}/.vim"
  ln -sfn $(pwd)/zshrc "${HOME}/.zshrc"
  ln -sfn $(pwd)/tmuxconf "${HOME}/.tmux.conf"
  ln -sfn $(pwd)/tigrc "${HOME}/.tigrc"
  ln -sfn $(pwd)/gitconfig "${HOME}/.gitconfig"
  ln -sfn $(pwd)/agignore "${HOME}/.agignore"
  ln -sfn $(pwd)/config "${HOME}/.config"
  ln -sfn $(pwd)/tmux "${HOME}/.tmux"
fi

VIM_PLUG_FILE="${HOME}/.vim/autoload/plug.vim"
if [ ! -f "${VIM_PLUG_FILE}" ]; then
  echo " ==> Installing vim-plug for vim"
  curl -fLo ${VIM_PLUG_FILE} --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

NVIM_PLUG_FILE="${HOME}/.local/share/nvim/site/autoload/plug.vim"
if [ ! -f "${NVIM_PLUG_FILE}" ]; then
  echo " ==> Installing vim-plug for neovim"
  curl -fLo ${NVIM_PLUG_FILE} --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo " ==> Installing Python client to neovim"
  pip2 install pynvim
  pip3 install pynvim
fi