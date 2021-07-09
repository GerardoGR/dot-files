#!/usr/bin/env bash

set -e

# Install packages
sudo apt install git vim-gtk3 tmux

# Setup dot-files
cd $HOME
git init
git remote add origin git@github.com:GerardoGR/dot-files.git || true
git pull
git checkout main
git submodule update --init --recursive
