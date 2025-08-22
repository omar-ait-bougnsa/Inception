# FROM debian:latest

# RUN apt update && \
#     apt install -y mariadb-server

# CMD ["mysqld_safe"]

FROM debian:latest

RUN apt-get update
RUN apt-get install -y mariadb-server \
    mariadb-client \
    vim 
    # && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
&& chown -R mysql:mysql /var/run/mysqld 
# && chmod 777 /var/run/mysqld

EXPOSE 3306
COPY ./conf/server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/setup.sh /usr/local/bin/
COPY ./conf/wordpress.sql /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/wordpress.sql

ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]

#Command to launch mariadb and enable the database to listen globally - also can be put on mysqldump.cnf file
CMD ["mysqld", "--bind-address=0.0.0.0"]
