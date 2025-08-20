FROM alpine:3.21.3

RUN apk update && apk upgrade && \
    apk add --no-cache mariadb mariadb-client mariadb-server-utils openrc bash

# Répertoire runtime
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

COPY ./conf/my.cnf /etc/my.cnf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
