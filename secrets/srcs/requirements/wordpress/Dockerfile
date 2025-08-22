FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-cli \
    php-common \
    php-json \
    php-opcache \
    php-xml \
    php-gd \
    php-curl \
    php-mbstring \
    mariadb-client \
    curl \
    unzip \
    less \
    iputils-ping \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php
RUN chown -R www-data:www-data /run/php

COPY conf/www.conf /etc/php/*/fpm/pool.d/.

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN touch /var/run/php/php-fpm.pid && \
    chown www-data:www-data /var/run/php/php-fpm.pid

ENTRYPOINT ["./setup.sh"]