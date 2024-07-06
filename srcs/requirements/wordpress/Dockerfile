FROM alpine:3.16

# Ensures www-data user exists
RUN adduser -u 82 -D -S -G www-data www-data

# Wordpress-CLI dependancies
RUN apk add --no-cache \
	curl \
	openssl \
	bash \
	mariadb-client \
	php8 \
	php8-fpm \
	php8-opcache \
	php8-mysqli \
	php8-session \
	php8-iconv \
	php8-json \
	php8-gd \
	php8-curl \
	php8-xml \
	php8-common \
	php8-imap \
	php8-cgi \
	php8-pdo \
	php8-pdo_mysql \
	php8-soap \
	php8-posix \
	php8-redis \
	php8-gettext \
	php8-ldap \
	php8-ctype \
	php8-dom \
	php8-phar


# php-fpm config
COPY conf/www.conf /etc/php8/php-fpm.d/

# install WordPress-CLI
RUN curl -o /usr/local/bin/wp -fL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x /usr/local/bin/wp; \
	wp --allow-root --version

# /var/www/html setup
RUN set -ex; \
	mkdir -p /var/www/html; \
	chown -R www-data:www-data /var/www/html


COPY docker-entrypoint.sh /usr/local/bin/
WORKDIR /var/www/html
ENTRYPOINT [ "sh", "/usr/local/bin/docker-entrypoint.sh" ]

CMD [ "php-fpm8", "-F", "-R"]
