#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

NATS_ADDRESS_IN_DOCKER="host.docker.internal"
NATS_TOPIC="payload.test"
NATS_SUB_COMMAND="nats reply -s nats://payloadtesttoken@${NATS_ADDRESS_IN_DOCKER}:4222 ${NATS_TOPIC} Hello > /dev/null"
NATS_SUB_SCRIPT_NAME="run-nats-subscriber.sh"

echo ${NATS_SUB_COMMAND} > ${NATS_SUB_SCRIPT_NAME}

docker run --rm -v $PWD:/workspace -it --add-host host.docker.internal:host-gateway synadia/nats-box /workspace/run-nats-subscriber.sh
