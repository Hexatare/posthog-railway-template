ARG POSTHOG_APP_TAG

FROM ghcr.io/posthog/posthog/cyclotron-janitor:${POSTHOG_APP_TAG}
