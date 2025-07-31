FROM alpine:3.21
ENV SQL_DATABASE=my_database \
	SQL_USER=my_user \
	SQL_PASSWORD=my_password \
	SQL_ROOT_PASSWORD=my_root_password

RUN apk update && apk add --no-cache mariadb mariadb-client bash
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
COPY conf/init.sh /init.sh
RUN chmod +x /init.sh

VOLUME /var/lib/mysql

EXPOSE 3306

CMD ["/init.sh"]