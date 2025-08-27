#!/bin/bash
set -e

sleep 10

# ensure target dir exists and use it
mkdir -p /var/www/wordpress
cd /var/www/wordpress

if [ ! -f wp-config.php ]; then
  wp core download --allow-root --path='.'
  wp config create --allow-root --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" --dbhost=mariadb:3306 --path='.'
  wp core install --allow-root --url="oait-bou.42.fr" --title="Iseption" \
    --admin_user="admin" --admin_password="admin123" --admin_email="admin@gmail.com" \
    --skip-email --path='.'
  wp user create --allow-root "${USER_LOGIN:-wp_user}" "${USER_EMAIL:-admin@example.com}" \
    --user_pass="${WP_USER_PASSWORD:-wp_password}" --role=subscriber || true
  chmod -R 775 wp-content
  echo "wp-config.php done"
else
  echo "wp-config.php already exists."
fi

# keep container running
exec /usr/sbin/php7.4-fpm -F