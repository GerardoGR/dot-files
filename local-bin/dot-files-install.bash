#!/usr/bin/env bash

set -e

# Common bash
ln -sf $HOME/.dot-files/bashrc $HOME/.bashrc
ln -sf $HOME/.dot-files/bash_profile $HOME/.bash_profile

# local bin paths
mkdir -p $HOME/.local
rm -rf $HOME/.local/dot-files-bin
ln -sf $HOME/.dot-files/local-bin $HOME/.local/dot-files-bin

# vim
rm -rf $HOME/.vim
ln -sf $HOME/.dot-files/vim $HOME/.vim

# tmux
mkdir -p $HOME/.tmux/
rm -rf $HOME/.tmux/plugins
ln -sf $HOME/.dot-files/tmux/plugins $HOME/.tmux/plugins
ln -sf $HOME/.dot-files/tmux/tmux.conf $HOME/.tmux.conf

# lightdm
sudo cp $HOME/.dot-files/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/
sudo chown root:root /etc/lightdm/lightdm-gtk-greeter.conf
sudo chmod 644 /etc/lightdm/lightdm-gtk-greeter.conf

# pacman-hooks
sudo mkdir -p /etc/pacman.d/hooks/
sudo cp $HOME/.dot-files/pacman-hooks/update-pkglists.hook /etc/pacman.d/hooks/

# xfce4
rm -rf $HOME/.config/xfce4/terminal $HOME/.config/xfce4/xfconf/xfce-perchannel-xml
ln -sf $HOME/.dot-files/xfce4/terminal $HOME/.config/xfce4/terminal
ln -sf $HOME/.dot-files/xfce4/xfconf/xfce-perchannel-xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml
xfce4-panel --quit ; pkill xfconfd ; xfce4-panel 2> /dev/null &

# asdf
rm -rf $HOME/.asdf
ln -sf $HOME/.dot-files/asdf/base $HOME/.asdf
ln -sf $HOME/.dot-files/asdf/tool-versions $HOME/.tool-versions

# asdf - install development environment
source $HOME/.bashrc
# asdf - install plugins defined in tool-versions
for plugin in $(cat $HOME/.tool-versions | sed s/' .*$'//); do
  if ! asdf plugin list | grep $plugin > /dev/null 2>&1; then
    asdf plugin add $plugin
  fi
done
asdf install
