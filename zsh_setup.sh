#!/usr/bin/env sh

# ZSH Initial setup script - meant to be called from ~/dotfiles/install.sh
# Note - oh-my-zsh is installed outside of ~/dotfiles, but custom scripts are linked from dotfiles to within this install area 

# Only install if zsh is available
if [[ "`which -s zsh > /dev/null; echo $?`" == "0" ]]; then

  # Download oh-my-zsh - outside of ~/dotfiles
  if [[ ! -d ~/.oh-my-zsh ]]; then
    cd ~
    if [[ "`which -s curl > /dev/null; echo $?`" == "0" ]]; then
      ZSH=~/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    elif [[ "`which -s wget > /dev/null; echo $?`" == "0" ]]; then
      ZSH=~/.oh-my-zsh sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    elif [[ "`which -s fetch > /dev/null; echo $?`" == "0" ]]; then
      ZSH=~/.oh-my-zsh sh -c "$(fetch -o - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    else
      echo "Unable to install oh-my-zsh - no curl, wget, or fetch"
    fi

  fi

  if [[ -d ~/.oh-my-zsh ]]; then
    # Success installing - download plugins and link configs
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k   
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    backup_and_link .zshrc dotfiles/zsh/zshrc
    backup_and_link .p10k.zsh dotfiles/zsh/p10k.zsh
    backup_and_link .oh-my-zsh/custom/russ.zsh ~/dotfiles/zsh/custom/russ.zsh
  fi
fi
