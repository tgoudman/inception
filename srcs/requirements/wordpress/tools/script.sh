#!/bin/bash
set -eu

echo "🔍 Vérification de la base de données..."

until mysqladmin ping -h "${mysql_host}" -u"${mysql_user}" -p"${mysql_password}" --silent; do
    echo "⏳ En attente de MariaDB..."
    sleep 5
done

echo "Construction de DB WordPress"

# Supprimer le wp-config.php existant si présent
if [ -f "/var/www/html/wp-config.php" ]; then
    echo "🗑 Suppression de l'ancien wp-config.php..."
    rm /var/www/html/wp-config.php
fi

# Créer un nouveau wp-config.php
wp config create --allow-root \
  --dbname="${database_name}" \
  --dbuser="${mysql_user}" \
  --dbpass="${mysql_password}" \
  --dbhost="${mysql_host}:3306" \
  --path='/var/www/html'

echo "✅ wp-config.php créé"

echo "✅ wp-config.php créé"

exec php-fpm8.2 -F
