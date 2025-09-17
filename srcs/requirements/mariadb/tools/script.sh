#!/bin/bash
set -eu

echo "🔧 Préparation de la base de données..."
mkdir -p /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql

echo "🔍 Vérification de l'initialisation de MariaDB..."

# Si MariaDB n'est pas encore initialisé, initialiser avec un mot de passe vide
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "📦 Initialisation de MariaDB..."
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

echo "🚀 Démarrage de MariaDB..."
# Lancer MariaDB en arrière-plan
mysqld_safe --datadir="/var/lib/mysql" --skip-networking &

# Attendre que le serveur MariaDB soit prêt
echo "⏳ Attente de MariaDB..."
until mysqladmin ping --silent; do
    echo "… en attente de MariaDB"
    sleep 1
done

# Configuration de la base de données
echo "🛠️ Configuration de la base de données..."
mysql -u root -p"${mysql_root_password}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${database_name}\`;
    CREATE USER IF NOT EXISTS '${mysql_user}'@'%' IDENTIFIED BY '${mysql_password}';
    GRANT ALL PRIVILEGES ON \`${database_name}\`.* TO '${mysql_user}'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Pas besoin d'arrêter MariaDB ici, il est déjà en train de tourner
# On ne fait qu'attendre pour laisser MariaDB tourner en arrière-plan

echo "✅ Configuration terminée, MariaDB est prêt !"

# Garder MariaDB en marche pour le conteneur
tail -f /dev/null
