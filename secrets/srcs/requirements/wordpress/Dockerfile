FROM debian:latest

RUN apt update && \
    apt install -y php php-fpm php-mysql wget unzip && \
    mkdir -p /var/www/html && \
    wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip && \
    unzip /tmp/wordpress.zip -d /tmp && \
    cp -r /tmp/wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html && \
    rm -rf /tmp/wordpress /tmp/wordpress.zip

WORKDIR /var/www/html

CMD ["php-fpm", "-F"]
