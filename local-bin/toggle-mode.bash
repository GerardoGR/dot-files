#!/usr/bin/env bash

set -e

vim_current_background=$(grep "set background=" ~/.vim/vimrc | awk -F 'set background=' '{print $2}')
vim_desired_background=dark
if [ $vim_current_background == "dark" ]; then
  vim_desired_background=light
fi
sed -i --follow-symlinks -r "s/set background=$vim_current_background/set background=$vim_desired_background/g" ~/.vim/vimrc

tmux_current_background=$(grep "set -g @colors-solarized " ~/.tmux.conf | awk -F 'set -g @colors-solarized ' '{print $2}' | sed -r "s/'//g")
tmux_desired_background=dark
if [ $tmux_current_background == "dark" ]; then
  tmux_desired_background=light
fi
sed -i --follow-symlinks -r "s/set -g @colors-solarized '$tmux_current_background'/set -g @colors-solarized '$tmux_desired_background'/g" ~/.tmux.conf
tmux source-file ~/.tmux.conf
