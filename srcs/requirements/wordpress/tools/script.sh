#!/bin/bash
set -eu

# Extraire le hostname de DOMAIN_NAME
HTTP_HOST="${DOMAIN_NAME#http://}"
HTTP_HOST="${HTTP_HOST#https://}"
HTTP_HOST="${HTTP_HOST%%:*}"

export HTTP_HOST

echo "DEBUG: DOMAIN_NAME='$DOMAIN_NAME'"
echo "DEBUG: HTTP_HOST='$HTTP_HOST'"
echo "DEBUG: WP_ADMIN_EMAIL='$WP_ADMIN_EMAIL'"

until mysqladmin ping -h "${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" --silent; do
    echo "Retry if MariaDB fail"
    sleep 5
done

echo "download WordPress"
if [ ! -f /var/www/html/index.php ]; then
  wp core download --allow-root --path=/var/www/html
fi

echo "supress wp-config.php..."
rm -f /var/www/html/wp-config.php

wp config create --allow-root \
  --dbname="$DB_NAME" \
  --dbuser="$DB_USER" \
  --dbpass="$DB_PASSWORD" \
  --dbhost="$DB_HOST" \
  --path=/var/www/html

# INstall Wordpress
if ! env HTTP_HOST="$HTTP_HOST" wp core is-installed --allow-root --path=/var/www/html; then
  env HTTP_HOST="$HTTP_HOST" wp core install --allow-root --path=/var/www/html \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USR" \
    --admin_password="$WP_ADMIN_PWD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email
    wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
else
  echo "Wordpress already here"
fi

exec php-fpm8.2 -F
