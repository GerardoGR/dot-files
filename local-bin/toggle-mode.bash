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

terminal_current_background=$(grep "ColorForeground=" ~/.config/xfce4/terminal/terminalrc | awk -F 'ColorForeground=' '{print $2}')
# if terminal_current_background is dark
if [ $terminal_current_background == "#839496" ]; then
  sed -i --follow-symlinks -r "s/ColorForeground=#839496/ColorForeground=#073642/g" ~/.config/xfce4/terminal/terminalrc
  sed -i --follow-symlinks -r "s/ColorBackground=#002b36/ColorBackground=#fdf6e3/g" ~/.config/xfce4/terminal/terminalrc
  sed -i --follow-symlinks -r "s/ColorCursor=#93a1a1/ColorCursor=#073642/g" ~/.config/xfce4/terminal/terminalrc
  sed -i --follow-symlinks -r "s/ColorBold=#93a1a1/ColorBold=#073642/g" ~/.config/xfce4/terminal/terminalrc
else
  sed -i --follow-symlinks -r "s/ColorForeground=#073642/ColorForeground=#839496/g" ~/.config/xfce4/terminal/terminalrc
  sed -i --follow-symlinks -r "s/ColorBackground=#fdf6e3/ColorBackground=#002b36/g" ~/.config/xfce4/terminal/terminalrc
  sed -i --follow-symlinks -r "s/ColorCursor=#073642/ColorCursor=#93a1a1/g" ~/.config/xfce4/terminal/terminalrc
  sed -i --follow-symlinks -r "s/ColorBold=#073642/ColorBold=#93a1a1/g" ~/.config/xfce4/terminal/terminalrc
fi
