FROM debian:buster

RUN apt update -y \
	&& apt install wget -y 

RUN  apt-get install -y apt-utils

RUN apt-get install -y php7.3\
	php-fpm\
	php-mysql\
	mariadb-client

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mkdir /usr/local/bin/wp
RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/wordpress



# Copy the auto_config.sh script
COPY tools/auto_config.sh /usr/local/bin/


# Make the script executable and run
RUN chmod +x /usr/local/bin/auto_config.sh
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]