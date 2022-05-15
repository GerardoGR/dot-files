#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# Otherwise start tmux
[[ -z "$TMUX" ]] && exec tmux

alias ls='ls --color=auto'
PS1='\w\$ '

PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/.local/dot-files-bin

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
