#!/bin/bash
set -e


if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

service mariadb start

while !mysqladmin ping --silent; do
  sleep 200
done

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

service mariadb stop

exec mysqld --bind-address=0.0.0.0