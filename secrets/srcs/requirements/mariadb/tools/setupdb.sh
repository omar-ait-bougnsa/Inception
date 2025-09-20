#!/bin/bash
set -e

first_time=0
if [ ! -f "/var/lib/mysql/.check" ]; then
  echo "-----------------"
  echo "First time initialization"
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  touch /var/lib/mysql/.check
  first_time=1
fi
echo "starting mariadb----------------"
service mariadb start

ROOT_PASSWORD="$(cat /run/secrets/db_root_password)"
WORDPRESS_DB_PASSWORD="$(cat /run/secrets/db_password)"
while ! mysqladmin ping --silent; do
    sleep 2
done
if [ "$first_time" = "1" ]; then
    mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';"
fi
mysql -uroot -p"${ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -uroot -p"${ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
mysql -uroot -p"${ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${WORDPRESS_DB_USER}'@'%';"
mysql -uroot -p"${ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p"${ROOT_PASSWORD}" shutdown

exec mysqld --bind-address=0.0.0.0