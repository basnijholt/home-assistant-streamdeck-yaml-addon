ARG BUILD_FROM=ghcr.io/hassio-addons/base:17.2.5
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Build arguments
ARG BUILD_ARCH=amd64
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
ARG VERSION=2025.7.0

# Install runtime dependencies and build dependencies
# hadolint ignore=DL3018,DL3003
RUN apk --no-cache add \
    # Python
    python3 \
    py3-pip \
    # Runtime dependencies
    libusb \
    hidapi \
    libffi \
    cairo \
    cairo-gobject \
    libxml2 \
    libxslt \
    libjpeg-turbo \
    zlib \
    freetype \
    libpng \
    # Build dependencies (will be removed after pip install)
    && apk add --no-cache --virtual .build-deps \
    gcc \
    python3-dev \
    musl-dev \
    libusb-dev \
    hidapi-dev \
    libffi-dev \
    cairo-dev \
    libxml2-dev \
    libxslt-dev \
    jpeg-dev \
    zlib-dev \
    freetype-dev \
    libpng-dev \
    # Download dependencies
    unzip \
    wget \
    # Download and install the application
    && echo "Downloading version ${VERSION}..." \
    && wget -nv https://github.com/basnijholt/home-assistant-streamdeck-yaml/archive/refs/tags/v${VERSION}.zip -O /tmp/v${VERSION}.zip \
    && echo "Unzipping..." \
    && unzip /tmp/v${VERSION}.zip -d /tmp \
    && mv /tmp/home-assistant-streamdeck-yaml-${VERSION} /app \
    && rm /tmp/v${VERSION}.zip \
    # Install Python dependencies
    && cd /app \
    && SETUPTOOLS_SCM_PRETEND_VERSION=${VERSION} pip install --no-cache-dir --break-system-packages -e "." \
    # Clean up build dependencies
    && apk del .build-deps

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
