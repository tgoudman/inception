FROM alpine:3.21

# Installer PHP, MariaDB client, wget, tar et bash
RUN apk update && apk add --no-cache \
    php84 php84-fpm php84-mysqli \
    mariadb-client wget tar bash

# Installer WordPress
RUN mkdir -p /var/www/wordpress \
    && wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /tmp \
    && tar -xzf /tmp/wordpress-6.0-fr_FR.tar.gz --strip-components=1 -C /var/www/wordpress \
    && rm /tmp/wordpress-6.0-fr_FR.tar.gz

# Installer WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copier la config WordPress et l'entrypoint
COPY conf/wp-config.php /var/www/wordpress/wp-config.php
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Créer le répertoire pour php-fpm
RUN mkdir -p /run/php

# Configurer php-fpm pour écouter sur toutes les interfaces
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php84/php-fpm.d/www.conf

# Exposer php-fpm sur le port 9000
EXPOSE 9000

# Lancer l’entrypoint
CMD ["/entrypoint.sh"]
