#!/bin/bash
set -e

mkdir -p /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress

cd /var/www/wordpress

WORDPRESS_DB_PASSWORD="$(cat /run/secrets/db_password)"
USER_PASSWORD="$(cat /run/secrets/user_password)"
if [ ! -f "wp-config.php" ]; then
  echo "downloading wordpress core files"
  wp core download --allow-root

  echo  "\ncreating wp-config.php"

  wp config create --allow-root \
    --dbname="$DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST"

  echo  "\nInstalling wordpress"

  wp core install --allow-root \
    --url="$URL" \
    --title="$TITLE" \
    --admin_user="$WORDPRESS_DB_USER" \
    --admin_password="$WORDPRESS_DB_PASSWORD" \
    --admin_email="$ADMIN_EMAIL"

  wp user create --allow-root \
    "$USER" "$USER_EMAIL" \
    --role=author \
    --user_pass="$USER_PASSWORD"
else
  echo "WordPress already installed, skipping install steps."
fi

echo "\nstarting php-fpm"
exec php-fpm7.4 -F