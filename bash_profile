export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/dot-files-bin

[[ -r ~/.bashrc ]] && . ~/.bashrc

# Editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
