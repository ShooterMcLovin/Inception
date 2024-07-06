#!/bin/sh

while ! mariadb -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE &>/dev/null; do
    sleep 5
done

if [ ! -f /tmp/done_config ]; then
	touch /tmp/done_config

	wp core download --allow-root
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --dbcharset="utf8" \
		--dbcollate="utf8_general_ci" --path="/var/www/html" --allow-root
    wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE \
		--admin_user=$WORDPRESS_ADMIN --admin_password=$WORDPRESS_ADMIN_PASSWORD \
		--admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=author \
		--user_pass=$WORDPRESS_PASSWORD --allow-root
fi

exec "$@"