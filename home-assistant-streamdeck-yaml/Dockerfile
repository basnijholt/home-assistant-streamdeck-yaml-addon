ARG BUILD_FROM=ghcr.io/hassio-addons/base:17.2.5

FROM python:3.14-alpine3.21 as python-build

# Stream Deck dependencies
# Install dependencies
RUN apk --no-cache add \
    # Stream Deck dependencies
    libusb=1.0.27-r0 \
    libusb-dev=1.0.27-r0 \
    hidapi-dev=0.14.0-r0 \
    libffi-dev=3.4.7-r0 \
    # Needed for cairosvg
    cairo-dev=1.18.4-r0 \
    # Needed for lxml
    libxml2-dev=2.13.4-r6 \
    libxslt-dev=1.1.42-r2 \
    # Needed for Pillow
    jpeg-dev=9f-r0 \
    zlib-dev=1.3.1-r2 \
    freetype-dev=2.13.3-r0 \
    libpng-dev=1.6.47-r0 \
    # Needed for pip install
    && apk add --no-cache --virtual build-deps \
    # General
    gcc=14.2.0-r4 \
    python3-dev=3.12.11-r0 \
    musl-dev=1.2.5-r9

# Download and unzip the repository
ARG VERSION=2025.7.0
# hadolint ignore=SC2034
RUN apk --no-cache --virtual .download-deps add \
    unzip=6.0-r15 \
    wget=1.25.0-r0 && \
    echo "Downloading version ${VERSION}..." && \
    wget -nv https://github.com/basnijholt/home-assistant-streamdeck-yaml/archive/refs/tags/v${VERSION}.zip -O v${VERSION}.zip && \
    echo "Unzipping..." && \
    unzip v${VERSION}.zip && \
    echo "Moving files..." && \
    mv home-assistant-streamdeck-yaml-${VERSION} /app && \
    echo "Cleaning up..." && \
    rm v${VERSION}.zip && \
    apk del .download-deps

# Set the working directory to the repository
WORKDIR /app

# Install the required dependencies
RUN SETUPTOOLS_SCM_PRETEND_VERSION=${VERSION} pip3 install -e "." --no-cache-dir
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Build arguments
ARG BUILD_ARCH=amd64
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
ARG BUILD_FROM

# Copy installed Python and libraries from the previous stage
COPY --from=python-build /usr/local /usr/local
COPY --from=python-build /app /app
COPY --from=python-build /usr/lib /usr/lib

# Copy rootfs
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
