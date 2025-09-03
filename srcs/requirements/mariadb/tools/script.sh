#!/bin/bash
set -e

# Initialisation de la BDD au premier lancement
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "=> Initialisation de la base MariaDB..."
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Démarrage temporaire de MariaDB en arrière-plan
mysqld_safe --skip-networking &
sleep 5

# Création de la base et de l'utilisateur
echo "=> Création de la base et de l'utilisateur..."
mariadb <<-EOSQL
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';
FLUSH PRIVILEGES;
EOSQL

# Stop temporairement MariaDB
mysqladmin -u root -p12345 shutdown

# Redémarrage en mode normal (process principal Docker)
exec mysqld_safe
