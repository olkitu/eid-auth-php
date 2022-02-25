#!/bin/sh
set -e

cd /etc/ssl/eid/crl
#
# Download CRL lists
#
echo "Downloading CRL lists"

# https://dvv.fineid.fi/en/certificate-index
DVV_CRL_URL="http://proxy.fineid.fi/crl/"
DVV_CRL_LIST=("vrkroot2c.crl" "dvvroot3rc.crl" "dvvroot3ec.crl" "vrkcqc2c.crl" "vrkcqc3c.crl" "dvvcqc4rc.crl")

for CRL_FILE in ${DVV_CRL_LIST[@]}; do
        echo "Downloading $CRL_FILE"
        curl -s $DVV_CRL_URL/$CRL_FILE -o $CRL_FILE
done

# https://www.skidsolutions.eu/en/repository/CRL/
echo "Download EE-GovCA2018.crl"
curl -s https://c.sk.ee/EE-GovCA2018.crl -o EE-GovCA2018.crl
echo "Download esteid2018.crl"
curl -s https://c.sk.ee/esteid2018.crl -o esteid2018.crl

# https://www.cartaidentita.interno.gov.it/fornitori-di-servizi/certification-autority/
echo "Download ciesubca1.crl"
curl -s https://ldap.cie.interno.gov.it/ciesubca1.crl -o ciesubca1.crl
echo "Download ciesubca002.crl"
curl -s https://ldap.cie.interno.gov.it/ciesubca002.crl -o ciesubca002.crl

# https://www.bsi.bund.de/EN/Topics/ElectrIDDocuments/CVCAeID/CVCAeID_node.html
echo "Download MDS_CRL.crl"
curl -s https://download.gsb.bund.de/BSI/crl/MDS_CRL.crl -o MDS_CRL.crl

for i in *.crl;
do
        echo "Convert $i to DER format"
        openssl crl -in $i -inform DER -out $i
        ln -sf $i `openssl crl -noout -hash -in $i`.r0;
done

cd /

echo "Start Apache"

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
        set -- apache2-foreground "$@"
fi

exec "$@"