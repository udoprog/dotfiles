set -g prefix C-a
set -g mode-keys vi
set set-titles on
bind-key a send-prefix
set-environment SSH_AUTH_SOCK ~/.cache/ssh_auth_sock

# Bind hjkl browsing {
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    bind -r H resize-pane -L 1
    bind -r J resize-pane -D 1
    bind -r K resize-pane -U 1
    bind -r L resize-pane -R 1

    bind -r M-h swap-window -t :-
    bind -r M-j swap-pane -D
    bind -r M-k swap-pane -U
    bind -r M-l swap-window -t :+
# }

# powerline {
    source PWD/powerline/powerline/bindings/tmux/powerline.conf
# }
