#!/bin/bash
set -e

mkdir -p /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress

cd /var/www/wordpress

echo "downloading wordpress core files"

wp core download --allow-root

echo -e "\ncreating wp=config.php"
wp config create --allow-root \
  --dbname="$WORDPRESS_DB_NAME" \
  --dbuser="$WORDPRESS_DB_USER" \
  --dbpass="$WORDPRESS_DB_PASSWORD" \
  --dbhost="$WORDPRESS_DB_HOST"


echo -e "\nInstalling wordpress"
wp core install --allow-root \
  --url="http://oait-bou.42.fr" \
  --title="Inception" \
  --admin_user="$WORDPRESS_DB_USER" \
  --admin_password="$WORDPRESS_DB_PASSWORD" \
  --admin_email="$USER_EMAIL"

wp user create --allow-root \
  "user2" "user2@example.com" \
  --role=author \
  --user_pass="user123"

echo -e "\nstarting php-fpm"
exec php-fpm7.4 -F