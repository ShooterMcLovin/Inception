#!/bin/bash

# # Remove existing wp-config.php
# if [ -f /var/www/wordpress/wp-config.php ]; then
#     echo "Removing existing wp-config.php..."
#     rm /var/www/wordpress/wp-config.php
# fi

# Sleep for 30 seconds to ensure MariaDB is up and running
echo "Waiting for MariaDB to start..."
sleep 30

if [ -f ./wp-config.php ]; then
    echo "WordPress is already installed"
else

	wget http://wordpress.org/latest.tar.gz -P /var/www/wordpress
	tar -xzf latest.tar.gz && rm latest.tar.gz
	mv wordpress/* .
	rm -rf wordpress

   /usr/local/bin/wp/wp-cli.phar config create \
    --allow-root \
    --path=/var/www/wordpress \
    --dbname=$SQL_DATABASE \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb:3306 \

# Run WordPress installation
	echo "Installing WordPress..."
	/usr/local/bin/wp/wp-cli.phar core install \
		--allow-root \
		--path=/var/www/wordpress \
		--url=http://localhost \
		--title=$WORDPRESS_DOMAIN_NAME \
		--admin_user=$WORDPRESS_ROOT_LOGIN \
		--admin_password=$WORDPRESS_ROOT_PASS \
		--admin_email=$WORDPRESS_ROOT_EMAIL

# Create additional WordPress user
	echo "Creating additional WordPress user..."
	/usr/local/bin/wp/wp-cli.phar user create \
		--allow-root \
		--path=/var/www/wordpress \
		$WORDPRESS_USER_NAME \
		$WORDPRESS_USER_EMAIL \
		--role=author

    echo "WordPress setup completed successfully!"
fi

# Ensure the directory exists
mkdir -p /run/php

echo "Starting PHP"
exec /usr/sbin/php-fpm7.3 -F