ZSH=$HOME/.oh-my-zsh
ZSH_THEME="{{zsh_theme}}"
plugins=(
{{#zsh_plugins}}
  {{name}}
{{/zsh_plugins}}
)
source $ZSH/oh-my-zsh.sh
source ~/.profile
source ~/.zshrc_custom

if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

if command -v upd > /dev/null 2>&1; then
    DOTFILES_UPDATE=updates-only upd
fi
