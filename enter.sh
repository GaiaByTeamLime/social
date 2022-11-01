#!/bin/sh

BUFFER_NAME=''$(echo -n "''$PWD" | xxd -ps -c 200 | tr -d '\n' | shasum | head -c -4)

tmux -L "$BUFFER_NAME" has-session -t "$BUFFER_NAME" || {
    tmux -L "$BUFFER_NAME" new-session -d -s "$BUFFER_NAME" "dockerd-rootless"
    tmux -L "$BUFFER_NAME" new-window -d "sleep 10; docker-compose -H 'unix:///run/user/1000/docker.sock' down; docker-compose -H 'unix:///run/user/1000/docker.sock' up db redis"
    #tmux -L "$BUFFER_NAME" set -g status off
    tmux -L "$BUFFER_NAME" set -g pane-border-style fg=#0c0c0c
    tmux -L "$BUFFER_NAME" set -g pane-active-border-style "bg=default fg=#0c0c0c"
}

tmux -L "$BUFFER_NAME" attach -t "$BUFFER_NAME"


