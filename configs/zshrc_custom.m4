# vim: filetype=zsh

PATH=$PATH:$HOME/usr/bin
PATH=$PATH:$HOME/node_modules/.bin

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
    echo "Exporting: SSH_AUTH_SOCK=$SSH_AUTH_SOCK_LINK"
    export SSH_AUTH_SOCK="$SSH_AUTH_SOCK_LINK"
else
    if [[ -n $SSH_AUTH_SOCK ]]; then
        echo "Linking: $SSH_AUTH_SOCK_LINK -> $SSH_AUTH_SOCK"
        ln -sf "$SSH_AUTH_SOCK" "$SSH_AUTH_SOCK_LINK"
    fi
fi

_zsh_terminal_set_256color()
{
    [[ $TERM =~ "-256color$" ]] && return

    # search through ncurses terminfo descriptions
    for terminfos in "${HOME}/.terminfo" "/etc/terminfo" "/lib/terminfo" "/usr/share/terminfo" ; do
        if [[ -e "$terminfos"/$TERM[1]/${TERM}-256color || \
                -e "$terminfos"/${TERM}-256color ]] ; then
            export TERM="${TERM}-256color"
            return
        fi
    done
}

_zsh_terminal_set_256color
unset -f _zsh_terminal_set_256color
