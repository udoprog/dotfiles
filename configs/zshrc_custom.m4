# vim: filetype=zsh

PATH=$PATH:/home/udoprog/usr/bin

export PATH
export CORRECT_IGNORE='_*:.*'

export DEBEMAIL="EMAIL"
export DEBFULLNAME="NAME"

# Prefix PS1 with current schroot name if viable.
if [[ -n $SCHROOT_CHROOT_NAME ]]; then
    export PS1="<$SCHROOT_CHROOT_NAME> $PS1"
fi

# Shared auth socket for tmux.
SSH_AUTH_SOCK_LINK="$HOME/ssh_auth_sock"

if [[ -n $TMUX ]]; then
    export SSH_AUTH_SOCK="$SSH_AUTH_SOCK_LINK"
else
    ln -sf "$SSH_AUTH_SOCK" "$SSH_AUTH_SOCK_LINK"
fi

# Color terminals (gnome-terminal).
if [[ -n $COLORTERM ]]; then
    export TERM="xterm-256color"
fi
