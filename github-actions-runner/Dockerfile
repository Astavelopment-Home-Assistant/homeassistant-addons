ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV RUNNER_ALLOW_RUNASROOT="1"

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

ENV BUILD_ARCH=${BUILD_ARCH}

LABEL \
    io.hass.name="github-actions-runner" \
    io.hass.description="GitHub Actions runner integration" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="KdoSiOdJinud" \
    org.label-schema.description="GitHub Actions runner" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="homeassistant-github-actions-runner" \
    org.label-schema.schema-version="0.1.0" \
    org.label-schema.url="https://github.com/kdosiodjinud/homeassistant-addons/github-actions-runner" \
    org.label-schema.usage="https://github.com/kdosiodjinud/homeassistant-addons/github-actions-runner/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/kdosiodjinud/homeassistant-addons/github-actions-runner" \
    org.label-schema.vendor="KdoSiOdJinud Hass.io Addons"

RUN mkdir -p /actions-runner-tmp

WORKDIR /actions-runner-tmp

# Set the Runner version to the latest stable release
ENV RUNNER_VERSION="2.332.0"

RUN if [ "${BUILD_ARCH}" = "aarch64" ]; then \
      export download_link="https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz"; \
    elif [ "${BUILD_ARCH}" = "amd64" ]; then \
      export download_link="https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"; \
    elif [ "${BUILD_ARCH}" = "armhf" ] || [ "${BUILD_ARCH}" = "armv7" ]; then \
      export download_link="https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm-${RUNNER_VERSION}.tar.gz"; \
    elif [ "${BUILD_ARCH}" = "i386" ]; then \
      export download_link="https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"; \
    else \
      echo "Unsupported architecture: ${BUILD_ARCH}"; \
      exit 1; \
    fi; \
    curl -o actions-runner.tar.gz -L ${download_link} && \
    tar xzf actions-runner.tar.gz

COPY init.sh /
RUN chmod a+x /init.sh

CMD [ "/init.sh" ]
