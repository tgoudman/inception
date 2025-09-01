FROM debian:bookworm

# Install MariaDB
RUN apt-get update -y && \
    apt-get install -y mariadb-server && \
    mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql

# Copy setup script
COPY ./tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

# Allow external connections
RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Start MariaDB using mysqld directly (Docker best practice)
ENTRYPOINT ["/tmp/script.sh"]
