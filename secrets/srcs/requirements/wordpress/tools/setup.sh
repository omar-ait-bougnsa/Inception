sleep 10 

cd /var/www/wordpress

if [ ! -f wp-config.php ]; then
  wp core download --allow-root
  wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MSQL_USER --dbpass=$MSQL_PASSWORD --dbhost=mariadb:3306 --path='/var/www/wordpress'
  wp core install --allow-root --url="oait-bou.42.fr" --title="Iseption" --admin_user="admin" --admin_password="admin123" --admin_email="admin.gmail.com" --skip-email --path='/var/www/wordpress'
  wp user create --allow-root $USER_LOGIN $USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=subscriber
  chmod -R 775 wp-content
  echo "wp-config.php done"
else
  echo "wp-config.php already exists."
fi

php-fpm7.4 -F