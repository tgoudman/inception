FROM alpine:3.21
RUN apk update && apk add --no-cache wget tar
RUN apk add --no-cache\
	php84\
	php84-fpm\
	php84-mysqli\
	mariadb-client
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P r/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
COPY conf/wp-config.php /var/www/wp-config.php
EXPOSE 9000