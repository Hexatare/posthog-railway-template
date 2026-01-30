FROM postgres:15.12-alpine

COPY ./posthog/docker/postgres-init-scripts /docker-entrypoint-initdb.d
