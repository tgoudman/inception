#!/bin/sh
set -e

# Initialisation seulement si la base n'existe pas
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initialisation de MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    # Démarrage temporaire de MariaDB en arrière-plan avec socket seulement
    mariadbd --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock &
    pid="$!"

    # Attendre que le serveur soit prêt
    until mysqladmin ping --socket=/run/mysqld/mysqld.sock &>/dev/null; do
        sleep 1
    done

    echo "Configuration initiale..."
    mysql --socket=/run/mysqld/mysqld.sock <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    # Arrêter le serveur temporaire
    kill "$pid"
    wait "$pid"
fi

# S'assurer des bons droits
chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Démarrage final du serveur MariaDB sur TCP
exec mariadbd --user=mysql --console --bind-address=0.0.0.0 --port=3306 --socket=/run/mysqld/mysqld.sock
