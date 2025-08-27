#!/bin/bash
set -e

# initialize DB files if first run
if [ ! -d "/var/lib/mysql/mysql" ]; then
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# start temporary server
mariadbd-safe --datadir='/var/lib/mysql' &

# wait until ready
until mariadb-admin ping >/dev/null 2>&1; do
  sleep 1
done

# configure DB (first run)
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
  mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
  mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
  mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
  mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
  mariadb -e "FLUSH PRIVILEGES;"
fi

# authenticated shutdown of temp server
mariadb-admin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown || true

# exec final server
exec mariadbd --bind-address=0.0.0.0