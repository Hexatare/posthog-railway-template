FROM ghcr.io/posthog/posthog/livestream:master

# Create config directory and entrypoint that generates config at runtime
RUN mkdir -p /configs

# Create entrypoint script that generates config from env vars
RUN echo '#!/bin/sh\n\
cat > /configs/configs.yml << EOF\n\
debug: false\n\
kafka:\n\
    brokers: "${KAFKA_BROKERS:-kafka:9092}"\n\
    topic: "events_plugin_ingestion"\n\
    group_id: "livestream"\n\
    security_protocol: "PLAINTEXT"\n\
    session_recording_enabled: true\n\
    session_recording_security_protocol: "PLAINTEXT"\n\
mmdb:\n\
    path: "GeoLite2-City.mmdb"\n\
EOF\n\
exec /livestream\n' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
