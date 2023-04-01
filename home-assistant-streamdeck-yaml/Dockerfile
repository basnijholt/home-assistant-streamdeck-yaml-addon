ARG BUILD_FROM=ghcr.io/hassio-addons/base:13.2.0
FROM python:3.11-alpine3.17 as python-build

# Stream Deck dependencies
# Install dependencies
RUN apk --update --no-cache add \
    # Stream Deck dependencies
    libusb \
    libusb-dev \
    hidapi-dev \
    libffi-dev \
    # Needed for cairosvg
    cairo-dev \
    # Needed for lxml
    libxml2-dev libxslt-dev \
    # Needed for Pillow
    jpeg-dev zlib-dev freetype-dev libpng-dev \
    # Needed for pip install
    && apk add --virtual build-deps \
    # General
    gcc python3-dev musl-dev \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/{cache,log}/*

# Download and unzip the repository
RUN apk --update --no-cache --virtual unzipper add unzip wget && \
    wget https://github.com/basnijholt/home-assistant-streamdeck-yaml/archive/main.zip && \
    unzip main.zip && \
    mv home-assistant-streamdeck-yaml-main /app && \
    rm main.zip && \
    apk del unzipper

# Set the working directory to the repository
WORKDIR /app

# Install the required dependencies
RUN pip3 install -e "." --no-cache-dir

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
