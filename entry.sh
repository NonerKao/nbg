#!/bin/bash

NAME=HN
tmux new-session -d -s $NAME

tmux send-keys -t "=$NAME:=0" \
"echo -e 'To initialize, visit the following \n \
Blog: http://localhost:8327/blog \n \
Wiki: http://localhost:8327/note/install.php \n \
Git: http://localhost:8327/install'" \
	Enter

tmux new-window -d -t "=$NAME" -n gitea
tmux send-keys -t "=$NAME:=gitea" "gitea" Enter

tmux new-window -d -t "=$NAME" -n 'server'
tmux send-keys -t "=$NAME:=server" \
	"php-fpm" \
	Enter
tmux send-keys -t "=$NAME:=server" \
	"nginx" \
	Enter

tmux new-window -d -t "=$NAME" -n 'hugo'
tmux send-keys -t "=$NAME:=hugo" \
	"cd /root/blog && hugo -d /usr/share/webapps/dokuwiki/blog" \
	Enter

tmux attach-session -t "=$NAME"
