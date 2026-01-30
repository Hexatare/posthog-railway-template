ARG POSTHOG_APP_TAG

FROM ghcr.io/posthog/posthog/capture:${POSTHOG_APP_TAG}
