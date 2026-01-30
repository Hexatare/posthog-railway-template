FROM caddy:latest

ENTRYPOINT [ \
    "sh", \
    "-c", \
    "set -x && echo \"${CADDYFILE}\" > /etc/caddy/Caddyfile && echo \"${CADDY_EXTRA_CONFIG}\" >> /etc/caddy/Caddyfile && exec caddy run -c /etc/caddy/Caddyfile" \
    ]
