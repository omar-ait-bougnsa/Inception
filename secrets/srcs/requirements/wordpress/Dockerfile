FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-cli \
    php7.4-common \
    php7.4-json \
    php7.4-opcache \
    php7.4-xml \
    php7.4-gd \
    php7.4-curl \
    php7.4-mbstring \
    mariadb-client \
    curl \
    unzip \
    wget \
    less \
    iputils-ping \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php
RUN chown -R www-data:www-data /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup.sh"]