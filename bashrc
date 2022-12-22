#
# ~/.bashrc
#

alias ls='ls --color=auto'
PS1='\h:\W\$ '

PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/.local/dot-files-bin

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# start the agent automatically and make sure that only one ssh-agent process runs at a time
# source: https://wiki.archlinux.org/title/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Firefox's wayland-mode
if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi

#AWSume alias to source the AWSume script
alias awsume="source awsume"

#Auto-Complete function for AWSume
_awsume() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(awsume-autocomplete)
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}
complete -F _awsume awsume
