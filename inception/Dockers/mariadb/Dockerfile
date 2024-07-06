FROM debian:buster
RUN apt update -y \
	&& apt upgrade -y \
    && apt-get install mariadb-server -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/

# Copy the initialization script
COPY /tools/init.sh /usr/local/bin

# chmod the initialization script
RUN chmod +x /usr/local/bin/init.sh

# run the initialization script
CMD ["/usr/local/bin/init.sh"]