# 1. Declare the Home Assistant injected argument at the absolute top
ARG BUILD_FROM

# 2. Fetch external dependencies
FROM docker.io/azbuilder/api-server:2.30.2 AS api
FROM docker.io/azbuilder/terrakube-ui:2.30.2 AS ui

# 3. Start the actual add-on stage using the global ARG
FROM ${BUILD_FROM}

# Set shell explicitly for better error handling
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# 4. Install packages with the Debian security patch for Nginx
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl=7.88.1-10+deb12u14 \
    nginx=1.22.1-9+deb12u4 \
    jq=1.6-2.1+deb12u1 \
    openjdk-17-jre-headless=17.0.17+10-1~deb12u1 \
    && rm -rf /var/lib/apt/lists/*

# 5. Copy the compiled assets from the previous stages
COPY --from=api / /opt/api/
COPY --from=ui / /opt/ui/

# 6. Copy your initialization script and set permissions
COPY init.sh /
RUN chmod a+x /init.sh

CMD [ "/init.sh" ]
