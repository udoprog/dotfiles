# quickcfg: zsh_theme, zsh_plugins:array
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="{{zsh_theme}}"
plugins=(
{{#each zsh_plugins}}  {{this.name}}{{/each}}
)
source $ZSH/oh-my-zsh.sh
source ~/.profile
source ~/.zshrc_custom

if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

if command -v quickcfg > /dev/null 2>&1; then
    quickcfg --updates-only --root $HOME/.dotfiles
    alias upd="quickcfg --root $HOME/.dotfiles"
fi
