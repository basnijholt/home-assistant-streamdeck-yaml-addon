ARG BUILD_FROM=ghcr.io/hassio-addons/base:17.2.1

FROM python:3.12-alpine3.17 as python-build

# Stream Deck dependencies
# Install dependencies
RUN apk --no-cache add \
    # Stream Deck dependencies
    libusb=1.0.26-r0 \
    libusb-dev=1.0.26-r0 \
    hidapi-dev=0.12.0-r1 \
    libffi-dev=3.4.4-r0 \
    # Needed for cairosvg
    cairo-dev=1.17.6-r3 \
    # Needed for lxml
    libxml2-dev=2.10.4-r0 \
    libxslt-dev=1.1.37-r1 \
    # Needed for Pillow
    jpeg-dev=9e-r0 \
    zlib-dev=1.2.13-r0 \
    freetype-dev=2.12.1-r0 \
    libpng-dev=1.6.44-r0 \
    # Needed for pip install
    && apk add --no-cache --virtual build-deps \
    # General
    gcc=12.2.1_git20220924-r4 \
    python3-dev=3.10.15-r0 \
    musl-dev=1.2.3-r6

# Download and unzip the repository
ARG VERSION=2024.12.10
# hadolint ignore=SC2034
RUN apk --no-cache --virtual unzipper add \
    unzip=6.0-r13 && \
    wget=1.21.4-r0 && \
    wget -nv https://github.com/basnijholt/home-assistant-streamdeck-yaml/archive/refs/tags/${VERSION}.zip && \
    unzip ${VERSION}.zip && \
    mv home-assistant-streamdeck-yaml-${VERSION} /app && \
    rm ${VERSION}.zip && \
    apk del unzipper

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
