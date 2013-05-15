PATH=$PATH:/home/udoprog/usr/bin

export PATH
export CORRECT_IGNORE='_*:.*'

export DEBEMAIL="EMAIL"
export DEBFULLNAME="NAME"
#export TERM=screen-256color

if [[ -f /etc/debian_version ]]; then
    PS1="(squeeze $(cat /etc/debian_version)) $PS1"
fi

VIRTUAL_SSH_AUTH_SOCK=$HOME/.cache/ssh_auth_sock

if [[ $SSH_AUTH_SOCK != $VIRTUAL_SSH_AUTH_SOCK ]]; then
    if [[ $(readlink $VIRTUAL_SSH_AUTH_SOCK) != $SSH_AUTH_SOCK ]]; then
        ln -sf $SSH_AUTH_SOCK $VIRTUAL_SSH_AUTH_SOCK
    fi

    export SSH_AUTH_SOCK=$VIRTUAL_SSH_AUTH_SOCK
fi
