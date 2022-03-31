#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

docker rm -f nats-main.example.com

docker run -d --name nats-main.example.com -v $(pwd)/certs/test-server.key:/test-server.key \
-v $(pwd)/certs/test-server.pem:/test-server.pem -v $(pwd)/nats-notls.conf:/nats-server.conf \
-p 4222:4222 -p 6222:6222 -p 8222:8222 -p 4242:4242 nats -c nats-server.conf

docker logs -f nats-main.example.com
