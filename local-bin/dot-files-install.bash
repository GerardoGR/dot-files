#!/usr/bin/env bash

set -e

# Common bash
ln -sf $HOME/.dot-files/bashrc $HOME/.bashrc
ln -sf $HOME/.dot-files/bash_profile $HOME/.bash_profile

# local bin paths
mkdir -p $HOME/.local
rm -rf $HOME/.local/dot-files-bin
ln -sf $HOME/.dot-files/local-bin $HOME/.local/dot-files-bin

# nvim
rm -rf $HOME/.config/nvim
ln -sf $HOME/.dot-files/nvim $HOME/.config/nvim
