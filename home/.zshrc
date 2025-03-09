# quickcfg: zsh_theme, zsh_plugins:array
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="{{zsh_theme}}"
plugins=(
{{#each zsh_plugins}}  {{this.name}}{{/each}}
)
source $ZSH/oh-my-zsh.sh
source ~/.zshrc_custom

if [[ $ZSH_HAS_PROFILE != "yes" ]]; then
    source ~/.profile
    export ZSH_HAS_PROFILE=yes
fi

if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

if command -v qc > /dev/null 2>&1; then
    qc --updates-only
    alias upd="qc"
fi
