#!/bin/sh

# ZSH Initial setup script

# Only install if zsh is available
if [ "`which -s zsh; echo $?`" != "0" ]; then

  # Download oh-my-zsh
  if [ ! -d ~/dotfiles/.oh-my-zsh ]; then
    if [ "`which -s curl; echo $?`" != "0" ]; then
      ZSH=~/dotfiles/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    elif [ "`which -s wget; echo $?`" != "0" ]; then
      ZSH=~/dotfiles/.oh-my-zsh sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    elif [ "`which -s fetch; echo $?`" != "0" ]; then
      ZSH=~/dotfiles/.oh-my-zsh sh -c "$(fetch -o - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    else
      echo "Unable to install oh-my-zsh - no curl, wget, or fetch"
    fi

  fi

  if [ -d ~/dotfiles/.oh-my-zsh ]; then
    # Success installing - link configs
    mv -f .zshrc .zshrc.off
    ln -s dotfiles/zsh/zshrc .zshrc
    mv -f .p10k.zsh .p10k.zsh.off
    ln -s dotfiles/zsh/p10k.zsh .p10k.zsh
  fi
fi
