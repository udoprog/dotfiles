ZSH=$HOME/.oh-my-zsh
ZSH_THEME="{{zsh_theme}}"
plugins=(
{{#zsh_plugins}}
  {{name}}
{{/zsh_plugins}}
)
source $ZSH/oh-my-zsh.sh
source ~/.zshrc_custom
