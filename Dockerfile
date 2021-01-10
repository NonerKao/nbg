FROM archlinux:latest

RUN yes | pacman -Syu nginx php php-fpm dokuwiki php-gd gitea tmux

ADD etc/php/php.ini /etc/php/php.ini
ADD etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD etc/gitea/app.ini /etc/gitea/app.ini
RUN echo -e 'set-option -g prefix C-a\n \
	unbind-key C-a\n \
	bind-key C-a send-prefix\n \
	setw -g mode-keys vi\n' > /root/.tmux.conf

RUN cp -pr /usr/share/webapps/dokuwiki /tmp/notehome
RUN cp -pr /tmp/notehome /usr/share/webapps/dokuwiki/note
RUN mv /tmp/notehome /usr/share/webapps/dokuwiki/blog

RUN cp -pr /var/lib/dokuwiki /tmp/notedata
RUN cp -pr /tmp/notedata /var/lib/dokuwiki/note
RUN mv /tmp/notedata /var/lib/dokuwiki/blog
RUN rm /usr/share/webapps/dokuwiki/note/data && ln -s ../../../../../var/lib/dokuwiki/note/data /usr/share/webapps/dokuwiki/note/data
RUN rm /usr/share/webapps/dokuwiki/blog/data && ln -s ../../../../../var/lib/dokuwiki/blog/data /usr/share/webapps/dokuwiki/blog/data

ADD entry.sh /
CMD ["/entry.sh"]
