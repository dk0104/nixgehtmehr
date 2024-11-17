# split panes using | -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# basic setup
# Use vim keybindings in copy mode
set-window-option -g mode-keys vi

# Escape turns on copy mode
bind Escape copy-mode

bind-key x kill-pane
setw -g aggressive-resize on
set -g status-position top
bind r source-file ~/.config/tmux/tmux.conf
TMUX_FZF_LAUNCH_KEY="C-k"

# Some other stuff
set -g allow-passthrough on
set -ga update-environment TERM
set -ga update-environment TERM_PROGRAM
set -g set-titles
