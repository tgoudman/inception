#!/bin/bash
set -eu

mkdir -p /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

mysqld_safe --datadir="/var/lib/mysql" &

until mysqladmin ping --silent; do
    echo "waiting for..."
    sleep 5
done

mysql -u root -p"${DB_USER}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Garder MariaDB en marche pour le conteneur
tail -f /dev/null
