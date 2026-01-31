FROM ghcr.io/posthog/posthog/livestream:master

COPY ./posthog/docker/livestream/configs-hobby.yml /configs/configs.yml
