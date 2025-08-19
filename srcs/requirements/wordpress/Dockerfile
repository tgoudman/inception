FROM alpine:3.21
RUN apk update && apk add --no-cache \
    php84 php84-fpm php84-mysqli \
    mariadb-client wget tar bash
RUN mkdir -p /var/www/wordpress \
    && wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /tmp \
    && tar -xzf /tmp/wordpress-6.0-fr_FR.tar.gz --strip-components=1 -C /var/www/wordpress \
    && rm /tmp/wordpress-6.0-fr_FR.tar.gz
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
COPY conf/wp-config.php /var/www/wordpress/wp-config.php
RUN mkdir -p /run/php
EXPOSE 9000
CMD ["php-fpm84", "--nodaemonize"]
