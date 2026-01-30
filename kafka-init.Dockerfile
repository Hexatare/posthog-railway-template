FROM docker.redpanda.com/redpandadata/redpanda:v25.1.9

ENTRYPOINT [ \
    "sh", \
    "-c", \
    " \
    set -x \
    echo "Waiting for Kafka broker to accept connections..." \
    TIMEOUT=60 \
    ELAPSED=0 \
    # Use rpk topic list as the readiness check - it's a simple operation \
    # that confirms the broker is accepting Kafka protocol requests \
    until rpk topic list --brokers kafka:9092 2>/dev/null; do \
    echo "Kafka broker not ready yet (elapsed: ${ELAPSED}s)..." \
    sleep 2 \
    ELAPSED=$((ELAPSED + 2)) \
    if [ $ELAPSED -ge $TIMEOUT ]; then \
    echo "Timeout waiting for Kafka broker after ${TIMEOUT}s" \
    echo "Final attempt to list topics:" \
    rpk topic list --brokers kafka:9092 || true \
    exit 1 \
    fi \
    done \
    echo "Kafka broker is accepting requests, creating topics..." \
    # Create topics needed by rust services \
    # Note: $$ escapes $ for docker-compose variable substitution \
    for topic in exceptions_ingestion clickhouse_events_json; do \
    if rpk topic create "$$topic" --brokers kafka:9092 -p 1 -r 1 2>&1; then \
    echo "Topic $$topic created successfully" \
    else \
    if rpk topic list --brokers kafka:9092 | grep -q "$$topic"; then \
    echo "Topic $$topic already exists, continuing" \
    else \
    echo "Failed to create topic $$topic" \
    exit 1 \
    fi \
    fi \
    done \
    echo "Final topic list:" \
    rpk topic list --brokers kafka:9092 \
    echo "Topics ready" \
    ", \
    ]
