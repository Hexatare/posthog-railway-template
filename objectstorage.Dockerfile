FROM minio/minio:RELEASE.2025-04-22T22-12-26Z

ENTRYPOINT ["sh", "-c", "mkdir -p /data/posthog /data/ducklake-dev /data/ai-blobs && minio server --address \":19000\" --console-address \":19001\" /data"]
