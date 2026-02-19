#!/usr/bin/env sh

function backup_and_link() {
  if [[ -e $1 && ! -L $1 ]]; then mv -f $1 $1.off; ln -s $2 $1;
  elif [[ -L $1 ]]; then echo "$1 is already a symlink - not modifying";
  else ln -s $2 $1;
  fi
}

cd ~
backup_and_link .bashrc dotfiles/bash/bashrc
backup_and_link .bash_profile dotfiles/bash/bash_profile
backup_and_link .vim dotfiles/vim
backup_and_link .vimrc dotfiles/vim/vimrc.vim
backup_and_link .tmux.conf dotfiles/tmux.conf

# If zsh is available, install zsh setup
source ~/dotfiles/zsh_setup.sh

# FIXME - make this a "heredoc"
echo << EOF 
Install done. On a private machine, also do this:
  mkdir -m 700 ~/.ssh
  cat dotfiles/ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
EOF