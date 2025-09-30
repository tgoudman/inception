#!/bin/bash
set -eu

DATADIR="/var/lib/mysql"

# Vérifie que les variables sont bien définies
: "${DB_NAME:?Missing DB_NAME}"
: "${DB_USER:?Missing DB_USER}"
: "${DB_PASSWORD:?Missing DB_PASSWORD}"

# Prépare le dossier de données
mkdir -p "$DATADIR"
chown -R mysql:mysql "$DATADIR"

# Initialise la base si elle n’existe pas
if [ ! -d "$DATADIR/mysql" ]; then
    echo "Initializing database..."
    mysqld --initialize-insecure --user=mysql --datadir="$DATADIR"
fi

# Lancer le serveur temporairement
echo "Starting temporary mysqld..."
mysqld --datadir="$DATADIR" --skip-networking --socket=/run/mysqld/mysqld.sock --user=mysql &
pid="$!"

# Attendre que le serveur démarre
until mysqladmin --socket=/run/mysqld/mysqld.sock ping --silent; do
    echo "Waiting for mysqld to be ready..."
    sleep 1
done

# Configurer la base de données
echo "Creating database and user..."
mysql --socket=/run/mysqld/mysqld.sock -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Arrêter le serveur temporaire
mysqladmin --socket=/run/mysqld/mysqld.sock -u root shutdown
wait "$pid"

# Démarrer le serveur final en mode foreground (PID 1)
echo "Starting final mysqld..."
exec mysqld --datadir="$DATADIR" --user=mysql --console
