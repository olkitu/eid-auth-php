#!/bin/sh
set -e

# Download CRL lists
curl -s http://proxy.fineid.fi/arl/vrkroota.crl -o /etc/ssl/eid/crl/vrkroota.crl
curl -s http://proxy.fineid.fi/crl/dvvroot3ec.crl -o /etc/ssl/eid/crl/dvvroot3ec.crl
curl -s http://proxy.fineid.fi/arl/vrkroot2a.crl -o /etc/ssl/eid/crl/vrkroot2a.crl
curl -s http://proxy.fineid.fi/crl/dvvroot3rc.crl -o /etc/ssl/eid/crl/dvvroot3rc.crl

cd /etc/ssl/eid/crl && for i in *.crl; do openssl crl -in $i -inform DER -out $i; ln -sf $i `openssl crl -noout -hash -in $i`.0; done

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
        set -- apache2-foreground "$@"
fi

exec "$@"