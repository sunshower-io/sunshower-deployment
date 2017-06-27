#!/bin/bash

PREFIX="keystore"


echo "Creating certificates with prefix $PREFIX";


openssl req -x509 -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout ${PREFIX}.key \
    -out ${PREFIX}.pem

openssl req -new \
    -key ${PREFIX}.key \
    -out ${PREFIX}.csr

openssl x509 -req -days 365 \
    -in ${PREFIX}.csr \
    -signkey ${PREFIX}.key \
    -out ${PREFIX}.crt

openssl pkcs12 -export \
    -in ${PREFIX}.crt \
    -inkey ${PREFIX}.key \
    -chain -CAfile ${PREFIX}.crt \
    -name "${PREFIX}" \
    -out ${PREFIX}.p12

keytool -importkeystore \
    -destkeystore ${PREFIX}.jks \
    -srckeystore ${PREFIX}.p12 \
    -srcstoretype PKCS12

mkdir ~/.sunshower/certs
cp *${PREFIX}* ~/.sunshower/certs

