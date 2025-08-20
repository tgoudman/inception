FROM alpine:3.21

# Installer MariaDB et bash
RUN apk update && apk add --no-cache mariadb mariadb-client bash

# Copier la configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Créer le répertoire des sockets et logs
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Copier le script d'initialisation
COPY conf/init.sh /init.sh
RUN chmod +x /init.sh

# Volume pour les données
VOLUME /var/lib/mysql

# Exposer le port MySQL
EXPOSE 3306

# Lancer MariaDB via le script d'initialisation
CMD ["/init.sh"]
