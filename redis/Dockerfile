# 1. Dummy argument to prevent Supervisor build errors
ARG BUILD_FROM

# 2. Strict pinned version of the lightweight Alpine Redis image
FROM redis:7.2.4-alpine

# Set shell explicitly
SHELL ["/bin/sh", "-c"]

# The official Redis image automatically handles the ENTRYPOINT and CMD 
# to start the redis-server on port 6379, so no custom run.sh is required.
