#!/bin/sh
cd ~
mv -f .bashrc .bashrc.off
mv -f .bash_profile .bash_profile.off
mv -f .vim .vim.off
mv -f .vimrc .vimrc.off
mv -f .tmux.conf .tmux.conf.off

ln -s dotfiles/bash/bashrc .bashrc
ln -s dotfiles/bash/bash_profile .bash_profile
ln -s dotfiles/vim/vimrc.vim .vimrc
ln -s dotfiles/vim .vim
ln -s dotfiles/tmux.conf .tmux.conf

# Create directory (if not already there) for local setup
# If zsh is available, install zsh setup
source ~/dotfiles/zsh_setup.sh

# FIXME - make this a "heredoc"
echo << EOF 
Install done. On a private machine, also do this:
  mkdir -m 700 ~/.ssh
  cat dotfiles/ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
EOF