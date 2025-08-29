#!/bin/bash
set -e


if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

service mariadb start

while !mysqladmin ping --silent; do
  sleep 2
done

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

service mariadb stop

exec mysqld --bind-address=0.0.0.0