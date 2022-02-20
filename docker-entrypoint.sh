#!/bin/sh
set -e

cd /etc/ssl/eid/crl
#
# Download CRL lists
#

# https://dvv.fineid.fi/en/certificate-index
curl -s https://dvv.fineid.fi/api/v1/cas/702/revocationlist -o vrkroot2c.crl
curl -s https://dvv.fineid.fi/api/v1/cas/711/revocationlist -o dvvroot3rc.crl
curl -s https://dvv.fineid.fi/api/v1/cas/712/revocationlist -o dvvroot3ec.crl
curl -s https://dvv.fineid.fi/api/v1/cas/101/revocationlist -o vrkcqc2c.crl
curl -s https://dvv.fineid.fi/api/v1/cas/102/revocationlist -o vrkcqc3c.crl
curl -s https://dvv.fineid.fi/api/v1/cas/112/revocationlist -o dvvcqc4ec.crl
curl -s https://dvv.fineid.fi/api/v1/cas/111/revocationlist -o dvvcqc4rc.crl

# https://www.skidsolutions.eu/en/repository/CRL/
curl -s https://c.sk.ee/EE-GovCA2018.crl -o EE-GovCA2018.crl

# https://www.cartaidentita.interno.gov.it/fornitori-di-servizi/certification-autority/
curl -s https://ldap.cie.interno.gov.it/ciesubca1.crl -o ciesubca1.crl
curl -s https://ldap.cie.interno.gov.it/ciesubca002.crl -o ciesubca002.crl

# https://www.bsi.bund.de/EN/Topics/ElectrIDDocuments/CVCAeID/CVCAeID_node.html
curl -s https://download.gsb.bund.de/BSI/crl/MDS_CRL.crl -o MDS_CRL.crl

for i in *.crl; do openssl crl -in $i -inform DER -out $i; ln -sf $i `openssl crl -noout -hash -in $i`.r0; done

cd /

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
        set -- apache2-foreground "$@"
fi

exec "$@"