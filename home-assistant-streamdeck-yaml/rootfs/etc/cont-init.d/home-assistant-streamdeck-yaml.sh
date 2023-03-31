#!/usr/bin/with-contenv bashio
# ==============================================================================
# Bas Nijholt's Hass.io Add-ons: home-assistant-streamdeck-yaml
# Handles configuration
# ==============================================================================

bashio::log.info "Initializing the config overwriting."

CONF=/etc/home-assistant-streamdeck-yaml/.env

hass_host=$(bashio::config "hass_host")
hass_token=$(bashio::config "hass_token")
streamdeck_config=$(bashio::config "streamdeck_config")
websocket_protocol=$(bashio::config "websocket_protocol")
hass_token_base64=`echo -n $hass_token | base64 -w 0`

sed -i "s/%%HASS_HOST%%/${hass_host}/g" ${CONF}
sed -i "s/%%HASS_TOKEN%%/${hass_token}/g" ${CONF}
sed -i "s/%%STREAMDECK_CONFIG%%/${streamdeck_config}/g" ${CONF}
sed -i "s/%%WEBSOCKET_PROTOCOL%%/${websocket_protocol}/g" ${CONF}

mv ${CONF} /app/.env

# Copy the Stream Deck YAML configuration file to the add-on
cp "${streamdeck_config}" /app/configuration.yaml

bashio::log.info "Finished the config overwriting."
