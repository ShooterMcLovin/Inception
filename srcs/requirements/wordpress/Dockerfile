# Use a specific base image that includes PHP 8.3 or higher
FROM php:8.3-fpm-alpine3.19

# Update and install required packages
RUN apk update && \
    apk add --no-cache \
    curl \
    openssl \
    bash \
    mariadb-client

RUN docker-php-ext-install mysqli

# install WordPress-CLI
RUN curl -o /usr/local/bin/wp -fL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x /usr/local/bin/wp; \
	wp --allow-root --version

# /var/www/html setup
RUN set -ex; \
	addgroup -g 82 -S www-data && \
	adduser -u 82 -D -S -G www-data www-data;\
	mkdir -p /var/www/html; \
	chown -R www-data:www-data /var/www/html

# PHP-FPM config
COPY conf/www.conf /etc/php8/php-fpm.d/

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/html
ENTRYPOINT [ "sh", "/usr/local/bin/docker-entrypoint.sh" ]

CMD ["php-fpm"]
