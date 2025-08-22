if [ ! -d "/var/lib/mysql/$MSQL_DATABASE" ]; then

   # echo "The database ${SQL_DATABASE} does not exist. Configuring..."#

    mysqld_safe --datadir='/var/lib/mysql' &

    sleep 10
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS '${USER_LOGIN}'@'%' IDENTIFIED BY '${USER_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${USER_LOGIN}'@'%' WITH GRANT OPTION;"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

    echo "SQL config done"

else  
    echo "Database already created"
fi

exec mariadbd