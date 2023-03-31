ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:6.2.4

FROM ${BUILD_FROM}

# Build arguments
ARG BUILD_ARCH=amd64
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
ARG BUILD_FROM

# Stream Deck dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libusb-1.0-0 \
        libusb-1.0-0-dev \
        libhidapi-dev \
        libffi-dev \
        libcairo2-dev \
        libxml2-dev \
        libxslt1-dev \
        libjpeg-dev \
        libz-dev \
        libfreetype6-dev \
        libpng-dev \
        gcc \
        python3-dev \
        python3-pip \
        wget \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/{cache,log}/*

# Clone the repository
RUN wget https://github.com/basnijholt/home-assistant-streamdeck-yaml/archive/main.zip && \
    unzip main.zip && mv home-assistant-streamdeck-yaml-main /app

# Set the working directory to the repository
WORKDIR /app

# Install the required dependencies
RUN pip3 install -e "."

# Purge the pip cache
RUN pip3 cache purge

COPY rootfs /

# Labels
LABEL \
    io.hass.name="home-assistant-streamdeck-yaml" \
    io.hass.description="home-assistant-streamdeck-yaml add-on" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Bas Nijholt <bas@nijho.lt>" \
    org.label-schema.description="home-assistant-streamdeck-yaml add-on" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="home-assistant-streamdeck-yaml" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/basnijholt/home-assistant-streamdeck-yaml-addon/tree/main/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/basnijholt/home-assistant-streamdeck-yaml-addon" \
    org.label-schema.vendor="Bas Nijholt"
