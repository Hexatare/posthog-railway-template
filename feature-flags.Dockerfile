ARG POSTHOG_APP_TAG

FROM ghcr.io/posthog/posthog/feature-flags:${POSTHOG_APP_TAG}
