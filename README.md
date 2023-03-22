# eID Auth Test Site

Support login with Estonian and Finnish ID cards

* Trusted CA `eid/ca`.
* Trusted CA CRL: `eid/crl`.

## Dev

Generate certificates

```
$ export DOMAIN_NAME=localhost
$ openssl genrsa -out ./eid/server.key 2048
$ openssl req -new -key ./eid/server.key -out ./eid/server.csr -subj "/C=FI/ST=Uusimaa/L=Helsinki/O=Test/OU=Test Department/CN=$DOMAIN_NAME"
$ openssl x509 -req -days 365 -in ./eid/server.csr -signkey ./eid/server.key -out ./eid/server.crt
$ rm ./eid/server.csr
```

Start container in compose

```
docker-compose up -d --build
```