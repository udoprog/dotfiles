# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.config/nvim/plugged/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.local/share/nvim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.local/share/nvim/plugged/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.local/share/nvim/plugged/fzf/shell/key-bindings.zsh"