# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.config/nvim/plugged/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.config/nvim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.config/nvim/plugged/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.config/nvim/plugged/fzf/shell/key-bindings.zsh"
