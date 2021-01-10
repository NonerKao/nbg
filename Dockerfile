FROM archlinux:latest

RUN yes | pacman -Syu nginx php php-fpm dokuwiki php-gd gitea tmux

ADD etc/php/php.ini /etc/php/php.ini
ADD etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD etc/gitea/app.ini /etc/gitea/app.ini
RUN echo -e 'set-option -g prefix C-a\n \
	unbind-key C-a\n \
	bind-key C-a send-prefix\n \
	setw -g mode-keys vi\n' > /root/.tmux.conf

RUN mv /usr/share/webapps/dokuwiki /usr/share/webapps/note/
RUN mkdir /usr/share/webapps/dokuwiki
RUN mv /usr/share/webapps/note /usr/share/webapps/dokuwiki/note
RUN cp -r /usr/share/webapps/dokuwiki/note /usr/share/webapps/dokuwiki/blog



ADD entry.sh /
CMD ["/entry.sh"]
