#!/usr/bin/env bash

set -e

# Install packages
sudo apt install git vim-gtk3 tmux

# Setup dot-files
ln -sf $HOME/.dot-files/bashrc $HOME/.bashrc
ln -sf $HOME/.dot-files/bash_profile $HOME/.bash_profile

mkdir -p $HOME/.local
rm -rf $HOME/.local/dot-files-bin
ln -sf $HOME/.dot-files/local-bin $HOME/.local/dot-files-bin

rm -rf $HOME/.vim
ln -sf $HOME/.dot-files/vim $HOME/.vim

mkdir -p $HOME/.tmux/
rm -rf $HOME/.tmux/plugins
ln -sf $HOME/.dot-files/tmux/plugins $HOME/.tmux/plugins
ln -sf $HOME/.dot-files/tmux/tmux.conf $HOME/.tmux.conf

rm -rf $HOME/.asdf
ln -sf $HOME/.dot-files/asdf $HOME/.asdf
ln -sf $HOME/.dot-files/asdf-tool-versions $HOME/.tool-versions
source $HOME/.bashrc
asdf install
