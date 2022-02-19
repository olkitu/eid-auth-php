#!/bin/sh
set -e

cd /etc/ssl/eid/crl

# Download CRL lists
curl -s https://dvv.fineid.fi/api/v1/cas/702/revocationlist -o vrkroot2c.crl
curl -s https://dvv.fineid.fi/api/v1/cas/711/revocationlist -o dvvroot3rc.crl
curl -s https://dvv.fineid.fi/api/v1/cas/712/revocationlist -o dvvroot3ec.crl
curl -s https://dvv.fineid.fi/api/v1/cas/101/revocationlist -o vrkcqc2c.crl
curl -s https://dvv.fineid.fi/api/v1/cas/102/revocationlist -o vrkcqc3c.crl
curl -s https://dvv.fineid.fi/api/v1/cas/112/revocationlist -o dvvcqc4ec.crl
curl -s https://dvv.fineid.fi/api/v1/cas/111/revocationlist -o dvvcqc4rc.crl

curl -s http://c.sk.ee/EE-GovCA2018.crl -o EE-GovCA2018.crl



for i in *.crl; do openssl crl -in $i -inform DER -out $i; ln -sf $i `openssl crl -noout -hash -in $i`.r0; done

cd /

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
        set -- apache2-foreground "$@"
fi

exec "$@"