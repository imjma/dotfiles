# My dotfiles

## Installation

	git pull && git submodule update --init --recursive

  brew install reattach-to-user-namespace

## Tmux

Omarchy shortcuts and appearance, with macOS clipboard and built-in keybinding help.
Install with `brew install tmux`, then `chezmoi apply ~/.tmux.conf`.
Start with `tmux`; the status bar is at the top and mouse support is enabled.

- Prefix: `Ctrl-Space` or `Ctrl-b`.
- Option + Enter / Shift + Enter: split top/bottom / left/right; prefix then `h` / `v` also works.
- Ctrl + Option + arrows: focus a pane; add Shift to resize.
- Prefix then `c`: new window; Option + `1`–`9`: select window.
- Option + Left / Right: previous / next window; add Shift to move the window.
- Prefix then `r` / `R`: rename window / session.
- Prefix then `C`: create session; Option + Up / Down or prefix then `P` / `N`: previous / next session.
- Option + Escape or prefix then `x`: kill pane; prefix then `k`: kill window.
- Prefix then `X`: confirm killing the session.
- Prefix then `[`, `v`, select with movement keys, `y`: copy to macOS clipboard.
- Prefix then `?`: keybinding help; prefix then `q`: reload configuration.

No TPM plugins or `reattach-to-user-namespace` required for tmux.
These Omarchy shortcuts overlap AeroSpace's Option + `1`–`9` workspace bindings
and Ghostty's Option + Left / Right word navigation. Those apps' settings are unchanged.

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
