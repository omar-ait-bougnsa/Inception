FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y nginx  openssl

COPY	conf/nginx.conf /etc/nginx/nginx.conf
RUN     chmod 755 /etc/nginx/nginx.conf

EXPOSE 443

COPY tools/setupssl.sh /usr/local/bin/setupssl.sh
RUN chmod +x /usr/local/bin/setupssl.sh

CMD ["/usr/local/bin/setupssl.sh"]

