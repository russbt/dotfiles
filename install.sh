#!/bin/sh
cd ~
mv .bashrc .bashrc.off
mv .bash_profile .bash_profile.off
mv .vim .vim.off
mv .vimrc .vimrc.off

ln -s dotfiles/bash/bashrc .bashrc
ln -s dotfiles/bash/bash_profile .bash_profile
ln -s dotfiles/vim/vimrc.vim .vimrc
ln -s dotfiles/vim .vim

