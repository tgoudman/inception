FROM debian:bookworm

# Installation de MariaDB
RUN apt-get update -y && \
    apt-get install -y mariadb-server && \
    mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

# Configuration MariaDB
COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

# Script d'init (exécuté par ENTRYPOINT)
COPY ./tools/script.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/docker-entrypoint.sh"]
