PATH=$PATH:/home/udoprog/usr/bin

export PATH
export CORRECT_IGNORE='_*:.*'

export DEBEMAIL="EMAIL"
export DEBFULLNAME="NAME"

if [[ -n $SCHROOT_CHROOT_NAME ]]; then
    export PS1="<$SCHROOT_CHROOT_NAME> $PS1"
fi

if [[ -n $TMUX ]]; then
    link="$HOME/ssh_auth_sock"

    if [[ ! -L $link ]]; then
        ln -sf "$SSH_AUTH_SOCK" "$link"
    fi

    export SSH_AUTH_SOCK="$link"
fi
