#!/bin/sh
set -e

# Generate Self Signed SSL
openssl genrsa -out /etc/ssl/eid/server.key 2048 && 
    openssl req -new -key /etc/ssl/eid/server.key -out server.csr -subj "/C=FI/ST=Uusimaa/L=Helsinki/O=Test/OU=Test Department/CN=$DOMAIN_NAME" && \
    openssl x509 -req -days 365 -in server.csr -signkey /etc/ssl/eid/server.key -out /etc/ssl/eid/server.crt &&
    rm server.csr

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
        set -- apache2-foreground "$@"
fi

exec "$@"