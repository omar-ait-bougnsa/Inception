FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql

# Copy configuration file
COPY conf/server.conf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/setupdb.sh /usr/local/bin/setupdb.sh 

RUN chmod +x /usr/local/bin/setupdb.sh && \
    chown mysql:mysql /usr/local/bin/setupdb.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/setupdb.sh"]