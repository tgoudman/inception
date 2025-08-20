#!/bin/sh
set -e

# Création des dossiers nécessaires et permissions
mkdir -p /run/mysqld /var/log/mysql
chown -R mysql:mysql /run/mysqld /var/log/mysql /var/lib/mysql

# Initialisation seulement si la base n'existe pas
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "==> Initialisation de MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    echo "==> Démarrage temporaire pour initialisation des utilisateurs..."
    mariadbd --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock &
    pid="$!"

    # Attendre que MariaDB soit prêt
    until mariadb-admin --socket=/run/mysqld/mysqld.sock ping &>/dev/null; do
        sleep 1
    done

    echo "==> Exécution des commandes d'initialisation..."
    mariadb --socket=/run/mysqld/mysqld.sock <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    echo "==> Arrêt du serveur temporaire..."
    kill "$pid"
    wait "$pid"
fi

echo "==> Démarrage final de MariaDB..."
exec mariadbd --user=mysql --console --bind-address=0.0.0.0 --port=3306 --socket=/run/mysqld/mysqld.sock
