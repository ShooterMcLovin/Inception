FROM alpine:3.16

RUN apk update && apk upgrade
RUN apk add mariadb mariadb-client

# MariaDB configuration files
RUN rm -rf /etc/my.cnf
COPY config/my.cnf /etc/my.cnf

RUN mkdir -p /run/mysqld; \
	chown -R mysql:mysql /run/mysqld; \
	mkdir -p /var/lib/mysql; \
	chown -R mysql:mysql /var/lib/mysql; \
	mysql_install_db --basedir=/usr --user=$MYSQL_USER --datadir=/var/lib/mysql

# Runs setup script
COPY docker-entrypoint.sh /tmp/docker-entrypoint.sh
ENTRYPOINT [ "sh", "/tmp/docker-entrypoint.sh" ]

# Loads mysqld as PID 1
CMD [ "mysqld" ]
