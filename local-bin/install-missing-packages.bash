#!/usr/bin/env bash

set -e

# Assuming that ~/.dot-files/packages/{base, foreign.aur}.txt are readable by the user

# shellcheck disable=SC2024
sudo pacman -S --needed - < ~/.dot-files/packages/base.txt

# shellcheck disable=SC2024
sudo paru -S --needed - < ~/.dot-files/packages/foreign.aur.txt

# Expecting a newline separated file for flatpak
# shellcheck disable=SC2046
flatpak install flathub $(cat ~/.dot-files/packages/flathub.txt)
