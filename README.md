# NATS TLS Hang Reproduction

To run this scenario, make sure to pre-generate all necessary test-data and start a local NATS server and replier,
as described below.

## Preparation

Generating TLS certs:
```
cd certs
./generateCertificates.sh
```

Starting a nats-server and nats-replier via docker:
```
cd test-data
./start-nats-server.sh
./start-nats-replier.sh
```

## Running the scenario

Adaptations to the payload size can be made by adjusting the `payload_size_mb` in `src/main.rs`

```
cargo run
```

## Cleanup

Once you're done, make sure to stop and remove the nats-server container that was started

```
docker rm -f nats-main.example.com
```

