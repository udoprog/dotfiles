# quickcfg: zsh_theme, zsh_plugins:array
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="{{zsh_theme}}"
plugins=(
{{#each zsh_plugins}}
  {{this.name}}
{{/each}}
)

if [[ $ZSH_HAS_PROFILE != "yes" ]]; then
    source ~/.profile
    export ZSH_HAS_PROFILE=yes
fi

source $ZSH/oh-my-zsh.sh

# Prefix PS1 with current schroot name if viable.
if [[ -n $SCHROOT_CHROOT_NAME ]]; then
    export PS1="<$SCHROOT_CHROOT_NAME> $PS1"
fi

# Shared auth socket for tmux.
SSH_AUTH_SOCK_LINK="$HOME/ssh_auth_sock"

if [[ -n $TMUX ]]; then
    export SSH_AUTH_SOCK="$SSH_AUTH_SOCK_LINK"
else
    if [[ -n $SSH_AUTH_SOCK ]]; then
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

alias system-install="sudo emerge -tavuND --with-bdeps=y --verbose-conflicts @world"
alias system-update="sudo eix-sync"

if command -v nvim -> /dev/null; then
    alias vim=nvim
fi

if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

if command -v qc > /dev/null 2>&1; then
    qc --updates-only
    alias upd="qc"
fi
