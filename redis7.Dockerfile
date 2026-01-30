FROM redis:7.2-alpine

ENTRYPOINT ["redis-server", "--maxmemory-policy", "allkeys-lru", "--maxmemory", "200mb"]
