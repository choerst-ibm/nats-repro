use env_logger::Env;
use std::thread;
use std::time::{Duration, SystemTime};
use log::{debug, error, info};

fn send_nats_payload(subject: &str, payload: &str, connection: &nats::Connection) {
    let now = SystemTime::now();
    info!("Sending payload of size '{:?}' bytes to NATS on topic '{}'", payload.len(), subject);
    match connection.request(subject, payload) {
        Ok(response) => {
            info!("Successfully submitted message to subject '{}' and received result", subject);
            info!("Time taken to send request and receive reply was {} milliseconds", now.elapsed().unwrap().as_millis());
            debug!("Received response message '{:?}'", response.data);
        }
        Err(error) => {
            let error_message =
                format!("Error during publish to subject '{}': {:?}", subject, error);
            error!("{}", error_message);
        }
    }
}

fn main() {
    env_logger::Builder::from_env(Env::default().default_filter_or("info")).format_timestamp_nanos().init();

    let payload_size_mb = 15;
    let payload = "T".repeat(payload_size_mb * 1000 * 1000);
    let subject = "payload.test";

    info!("Establishing connection to NATS");
    let connection = nats::Options::with_token("payloadtesttoken")
                .add_root_certificate("test-data/certs/test-ca.pem")
                .connect("tls://localhost:4222")
                .unwrap();

    for run in 1..100 {
        info!("Run {}: Sending payload to NATS", run);
        send_nats_payload(subject, &payload, &connection);

        info!("Waiting 1 seconds between requests");
        thread::sleep(Duration::from_secs(1));
    }
}
