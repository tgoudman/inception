#!/bin/sh

# Initialiser la base de données si elle ne l'est pas encore
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initialisation de MariaDB..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    mysqld --user=mysql --bootstrap <<EOF
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
fi

# Démarrer MariaDB normalement
exec mysqld --user=mysql
