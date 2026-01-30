FROM ghcr.io/posthog/posthog:${POSTHOG_APP_TAG}

ENTRYPOINT [ "./bin/docker-worker-celery", "--with-scheduler" ]
