#!/bin/sh
set -e

# Attendre MariaDB
echo "Waiting for MariaDB..."
until mysql -h mariadb -u"$SQL_USER" -p"$SQL_PASSWORD" "$SQL_DATABASE" &> /dev/null; do
    sleep 2
done

echo "MariaDB ready, starting php-fpm"
php-fpm84 -F
