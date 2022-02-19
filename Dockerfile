FROM php:8.1-apache

ENV DOMAIN_NAME=localhost

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY eid /etc/ssl/eid/

RUN apt update && apt-get upgrade -y && apt install wget -y \
    && a2enmod ssl rewrite \
    && mkdir -p /etc/ssl/eid \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i -e 's/expose_php = On/expose_php = Off/' /usr/local/etc/php/php.ini \
    && cd /etc/ssl/eid/ca && for i in *.crt; do ln -s $i `openssl x509 -noout -hash -in $i`.0; done

COPY conf/apache.conf /etc/apache2/sites-available/000-default.conf
COPY site /var/www/html/

EXPOSE 443

ENTRYPOINT [ "bash", "/docker-entrypoint.sh" ]
CMD [ "apache2-foreground" ]