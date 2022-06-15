#!/usr/bin/env bash

set -e

# Taken from: https://github.com/Morganamilo/paru#installation
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

rm -r paru
