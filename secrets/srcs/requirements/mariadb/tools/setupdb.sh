#!/bin/bash
set -e


if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

service mariadb start

ROOT_PASSWORD="$(cat /run/secrets/db_root_password)"
WORDPRESS_DB_PASSWORD="$(cat /run/secrets/db_password)"
while ! mysqladmin ping --silent; do
    sleep 2
done
mysql -uroot -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -uroot -e "CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${WORDPRESS_DB_USER}'@'%';"
mysql -uroot -e "FLUSH PRIVILEGES;"

service mariadb stop

exec mysqld --bind-address=0.0.0.0