FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-client bash
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
COPY conf/init.sh /init.sh
RUN chmod +x /init.sh

VOLUME /var/lib/mysql

EXPOSE 3306

CMD ["/init.sh"]