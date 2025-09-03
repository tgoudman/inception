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

echo "🔍 Vérification de la base de données..."

until mysqladmin ping -h "${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" --silent; do
    echo "⏳ En attente de MariaDB..."
    sleep 5
done

echo "🔍 Téléchargement de WordPress si nécessaire..."
if [ ! -f /var/www/html/index.php ]; then
  wp core download --allow-root --path=/var/www/html
fi

echo "🗑 Suppression de l'ancien wp-config.php..."
rm -f /var/www/html/wp-config.php

echo "🛠 Création de wp-config.php"
wp config create --allow-root \
  --dbname="$DB_NAME" \
  --dbuser="$DB_USER" \
  --dbpass="$DB_PASSWORD" \
  --dbhost="$DB_HOST" \
  --path=/var/www/html

echo "✅ Démarrage de PHP-FPM"

# Installer WordPress en injectant explicitement HTTP_HOST dans l'environnement de la commande wp
if ! env HTTP_HOST="$HTTP_HOST" wp core is-installed --allow-root --path=/var/www/html; then
  echo "🛠 Installation de WordPress..."
  env HTTP_HOST="$HTTP_HOST" wp core install --allow-root --path=/var/www/html \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USR" \
    --admin_password="$WP_ADMIN_PWD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email
else
  echo "ℹ️ WordPress déjà installé."
fi

exec php-fpm8.2 -F
