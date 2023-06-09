#!/usr/bin/with-contenv bashio
# ==============================================================================
# Bas Nijholt's Hass.io Add-ons: home-assistant-streamdeck-yaml
# Handles configuration
# ==============================================================================

bashio::log.info "🚀 Initializing the config overwriting."

hass_host=$(bashio::config "hass_host")
hass_token=$(bashio::config "hass_token")
streamdeck_config=$(bashio::config "streamdeck_config")
websocket_protocol=$(bashio::config "websocket_protocol")
streamdeck_dotenv=$(bashio::config "streamdeck_dotenv")

if [[ -n "${streamdeck_dotenv}" ]]; then
    if [[ -e "${streamdeck_dotenv}" ]]; then
        bashio::log.info "🔍 Found the .env file: ${streamdeck_dotenv}"
    else
        bashio::log.red "❌ Error: The .env file does not exist: ${streamdeck_dotenv}"
        exit 1
    fi

    if [[ -n "${hass_host}" || -n "${hass_token}" || -n "${streamdeck_config}" || -n "${websocket_protocol}" ]]; then
        bashio::log.red "❌ Error: Configuration conflict. When using the .env file, all other configuration options must be empty."
        exit 1
    fi

    bashio::log.info "📁 Using the .env file from ${streamdeck_dotenv}"
    # Read STREAMDECK_CONFIG from .env file and copy the Stream Deck YAML configuration file to the add-on
    cp "${streamdeck_dotenv}" /app/.env
    streamdeck_config_from_env=$(grep STREAMDECK_CONFIG "${streamdeck_dotenv}" | cut -d'=' -f2)

    # Check if the path is relative
    if [[ "${streamdeck_config_from_env}" != /* ]]; then
        streamdeck_config_from_env=$(dirname "${streamdeck_dotenv}")/${streamdeck_config_from_env}
        bashio::log.info "🔍 Detected a relative path for STREAMDECK_CONFIG: ${streamdeck_config_from_env}"
    else
        bashio::log.info "🔍 Detected an absolute path for STREAMDECK_CONFIG: ${streamdeck_config_from_env}"
    fi

    bashio::log.info "📂 Copying the Stream Deck YAML configuration file to the add-on: ${streamdeck_config_from_env}"
    cp "${streamdeck_config_from_env}" /app/configuration.yaml

    # Remove STREAMDECK_CONFIG line from /app/.env file
    sed -i "/^STREAMDECK_CONFIG/d" /app/.env
else
    # Use automatic values for hass_host and hass_token if they are empty
    if [[ -z "${hass_host}" ]]; then
        if [[ -n "$websocket_protocol" ]]; then
            bashio::log.red "❌ Error: Configuration conflict. When using the supervisor as the Home Assistant host, the websocket_protocol must be empty."
            exit 1
        fi
        hass_host="supervisor/core"
        websocket_protocol="ws"
        bashio::log.info "🔍 Using the host of the Supervisor as the Home Assistant host: ${hass_host} with protocol ${websocket_protocol}"
    fi

    if [[ -z "${streamdeck_config}" || -z "${websocket_protocol}" ]]; then
        bashio::log.red "❌ Error: Configuration incomplete. When not using the streamdeck_dotenv configuration option, streamdeck_config and websocket_protocol (if not supervisor) must be provided."
        exit 1
    fi

    if [[ -z "${hass_token}" ]]; then
        bashio::log.info "🔍 Using the API token of the Supervisor as the Home Assistant token"
        hass_token="${SUPERVISOR_TOKEN}"
    fi

    bashio::log.info "🔧 Using add-on configuration values instead of .env file"
    {
        echo "HASS_HOST=$hass_host"
        echo "HASS_TOKEN=$hass_token"
        echo "STREAMDECK_CONFIG=$streamdeck_config"
        echo "WEBSOCKET_PROTOCOL=$websocket_protocol"
    } > /app/.env
    # Copy the Stream Deck YAML configuration file to the add-on
    bashio::log.info "📂 Copying the Stream Deck YAML configuration file to the add-on: ${streamdeck_config}"
    cp "${streamdeck_config}" /app/configuration.yaml
fi

bashio::log.info "✅ Finished the config overwriting."
