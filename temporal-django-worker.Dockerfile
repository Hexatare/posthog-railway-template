ARG POSTHOG_APP_TAG=latest

FROM ghcr.io/posthog/posthog:${POSTHOG_APP_TAG}

COPY ./compose /compose

ENTRYPOINT [ "/compose/temporal-django-worker" ]
