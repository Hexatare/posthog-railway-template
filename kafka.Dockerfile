FROM docker.redpanda.com/redpandadata/redpanda:v25.1.9

ENTRYPOINT [ \
    "redpanda", \
    "start", \
    "--kafka-addr", "internal://0.0.0.0:9092,external://0.0.0.0:19092", \
    "--advertise-kafka-addr", "internal://kafka:9092,external://localhost:19092", \
    "--pandaproxy-addr", "internal://0.0.0.0:8082,external://0.0.0.0:18082", \
    "--advertise-pandaproxy-addr", "internal://kafka:8082,external://localhost:18082", \
    "--schema-registry-addr", "internal://0.0.0.0:8081,external://0.0.0.0:18081", \
    "--rpc-addr", "kafka:33145", \
    "--advertise-rpc-addr", "kafka:33145", \
    "--mode", "dev-container", \
    "--smp", "2", \
    "--memory", "3G", \
    "--reserve-memory", "500M", \
    "--overprovisioned", \
    "--set", "redpanda.empty_seed_starts_cluster=false", \
    "--seeds", "kafka:33145", \
    "--set", "redpanda.auto_create_topics_enabled=true" \
    ]
