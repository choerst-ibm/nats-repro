#!/bin/bash

openssl genrsa -out test-ca.key 4096
openssl req -new -x509 -days 365 -key test-ca.key -out test-ca.pem -config openssl-test-ca.conf -batch

openssl genrsa -out test-server.key 4096
openssl req -new -key test-server.key -out test-server.csr -config openssl-test-server.conf -batch
openssl x509 -sha256 -req -days 730 -in test-server.csr -CA test-ca.pem -CAkey test-ca.key -CAcreateserial -out test-server.pem -extfile openssl-test-server.conf -extensions v3_req
