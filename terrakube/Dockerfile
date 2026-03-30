# 1. Fetch external dependencies using proper uppercase 'AS' to fix the casing warning
FROM docker.io/azbuilder/api-server:2.30.2 AS api
FROM docker.io/azbuilder/terrakube-ui:2.30.2 AS ui

# 2. Declare the Home Assistant injected argument right BEFORE the stage that uses it
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell explicitly for better error handling
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# 3. Install packages with the newly required Debian security patch for Nginx (deb12u4)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl=7.88.1-10+deb12u14 \
    nginx=1.22.1-9+deb12u4 \
    jq=1.6-2.1+deb12u1 \
    openjdk-17-jre-headless=17.0.17+10-1~deb12u1 \
    && rm -rf /var/lib/apt/lists/*

# 4. Copy the compiled assets from the previous stages
COPY --from=api / /opt/api/
COPY --from=ui / /opt/ui/

# 5. Copy your initialization script and set permissions
COPY init.sh /
RUN chmod a+x /init.sh

CMD [ "/init.sh" ]
