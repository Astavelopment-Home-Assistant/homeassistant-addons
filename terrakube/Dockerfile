ARG BUILD_FROM
FROM azbuilder/api-server:2.30.2 as api
FROM azbuilder/terrakube-ui:2.30.2 as ui
FROM $BUILD_FROM
# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl=7.88.1-10+deb12u14 \
    nginx=1.22.1-9+deb12u3 \
    jq=1.6-2.1+deb12u1 \
    openjdk-17-jre-headless=17.0.17+10-1~deb12u1 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=api /app /app
COPY --from=ui /usr/share/nginx/html /var/www/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
