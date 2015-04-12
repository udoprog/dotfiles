set -g prefix PROFILE_TMUX_PREFIX
set -g mode-keys vi
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
    set -g status on
    set -g status-utf8 on
    set -g status-interval 2
    set -g status-fg colour231
    set -g status-bg colour234
    set -g status-left-length 20
    set -g status-left '#[fg=colour16,bg=colour254,bold] #S #[fg=colour254,bg=colour234,nobold]#(powerline tmux left)'
    set -g status-right '#(powerline tmux right -R pane_id=`tmux display -p "#D"`)'
    set -g status-right-length 150
    set -g window-status-format "#[fg=colour244,bg=colour234]#I #[fg=colour240] #[fg=colour249]#W "
    set -g window-status-current-format "#[fg=colour234,bg=colour31]#[fg=colour117,bg=colour31] #I  #[fg=colour231,bold]#W #[fg=colour31,bg=colour234,nobold]"
# }
