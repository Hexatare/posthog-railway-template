ARG POSTHOG_APP_TAG

FROM ghcr.io/posthog/posthog:${POSTHOG_APP_TAG}

ENTRYPOINT [ "/compose/start" ]
