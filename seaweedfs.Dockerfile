FROM chrislusf/seaweedfs:4.03

COPY <<EOF /entrypoint.sh
#!/bin/sh
set -e

/usr/bin/weed "\$@" &
WEED_PID=\$!

echo "Waiting for SeaweedFS to initialize..."
while true; do
    sleep 5
    echo "Checking if posthog bucket exists..."
    if echo "s3.bucket.list" | /usr/bin/weed shell -master=localhost:9333 2>&1 | grep -q "posthog"; then
        echo "Bucket posthog exists!"
        break
    fi
    echo "Bucket not found, attempting to create..."
    echo "s3.bucket.create -name posthog" | /usr/bin/weed shell -master=localhost:9333 2>&1 || true
    echo "Retrying in 5s..."
done

echo "SeaweedFS ready with posthog bucket"
wait \$WEED_PID
EOF

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["server", "-s3", "-s3.port=8333", "-dir=/data"]
