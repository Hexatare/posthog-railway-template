FROM docker.redpanda.com/redpandadata/redpanda:v25.1.9

COPY --chmod=755 <<EOF /entrypoint.sh
#!/bin/bash
set -e
set -x

KAFKA_BROKERS=\${KAFKA_BROKERS:-kafka:9092}

echo "Waiting for Kafka broker to accept connections at \$KAFKA_BROKERS..."
TIMEOUT=60
ELAPSED=0
until rpk topic list --brokers "\$KAFKA_BROKERS" 2>/dev/null; do
  echo "Kafka broker not ready yet (elapsed: \${ELAPSED}s)..."
  sleep 2
  ELAPSED=\$((ELAPSED + 2))
  if [ \$ELAPSED -ge \$TIMEOUT ]; then
    echo "Timeout waiting for Kafka broker after \${TIMEOUT}s"
    echo "Final attempt to list topics:"
    rpk topic list --brokers "\$KAFKA_BROKERS" || true
    exit 1
  fi
done

echo "Kafka broker is accepting requests, creating topics..."
for topic in exceptions_ingestion clickhouse_events_json; do
  if rpk topic create "\$topic" --brokers "\$KAFKA_BROKERS" -p 1 -r 1 2>&1; then
    echo "Topic \$topic created successfully"
  else
    if rpk topic list --brokers "\$KAFKA_BROKERS" | grep -q "\$topic"; then
      echo "Topic \$topic already exists, continuing"
    else
      echo "Failed to create topic \$topic"
      exit 1
    fi
  fi
done

echo "Final topic list:"
rpk topic list --brokers "\$KAFKA_BROKERS"
echo "Topics ready"
EOF

ENTRYPOINT [ "/entrypoint.sh" ]
