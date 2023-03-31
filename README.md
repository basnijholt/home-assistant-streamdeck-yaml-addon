# [Home Assistant Stream Deck YAML Add-on](https://github.com/basnijholt/home-assistant-streamdeck-yaml) 🎮

This add-on allows you to control your Home Assistant instance via a Stream Deck, making it easier than ever to manage your smart home devices and scenes 🏠.
The add-on is highly customizable and configured using YAML files.
It runs on the same machine as Home Assistant and supports Linux-based supervised Home Assistant installations.
Check out the [GitHub repository](https://github.com/basnijholt/home-assistant-streamdeck-yaml) for more details.

## Features 🌟
- Easy to use 😄
- Highly customizable 🔧
- Runs on the same machine as Home Assistant 🏠
- Supports Linux-based supervised Home Assistant installations 🐧
- YAML configuration 📁
- Template support for advanced customization 🔥
- Automatically syncs state of `entity_id` to turn display on/off 💤

## Installation 📦

To install the add-on, follow these steps:

1. Go to Supervisor -> Add-on store -> Add new repository by URL and fill in `https://github.com/basnijholt/home-assistant-streamdeck-yaml-addon`.
2. Install the `home-assistant-streamdeck-yaml` add-on.

## Add-on Configuration ⚙️

There are two ways to configure the add-on:

### Option 1: Using individual configuration parameters

An example add-on configuration using individual parameters is shown below:

```yaml
hass_host: 192.168.1.2
hass_token: YOUR_LONG_LIVED_ACCESS_TOKEN
streamdeck_config: /config/streamdeck.yaml
websocket_protocol: wss
```

The configuration file includes the following parameters:

- `hass_host`: The IP address of your Home Assistant instance.
- `hass_token`: The long-lived access token for your Home Assistant instance.
- `streamdeck_config`: The path to your streamdeck configuration YAML file.
- `websocket_protocol`: The websocket protocol to use (`ws` for unsecured, `wss` for secured).

### Option 2: Using a `.env` file for configuration

An example add-on configuration using a `.env` file is shown below:

```yaml
streamdeck_dotenv: /config/streamdeck.env
```

The configuration file includes the following parameter:

- `streamdeck_dotenv`: The path to your `.env` file containing the necessary configuration values (e.g., `HASS_HOST`, `HASS_TOKEN`, `STREAMDECK_CONFIG`, and `WEBSOCKET_PROTOCOL`).

⚠️ Note that when specifying an `.env` file, you must include all of the configuration parameters in the `.env` file, and all the other configuration parameters are ignored.
Refer to the [`.env` file example](https://github.com/basnijholt/home-assistant-streamdeck-yaml/blob/main/.env.example) for more details.

## Stream Deck Configuration 🎮

Create a `configuration.yaml` file for your Stream Deck buttons following the [example configuration](https://github.com/basnijholt/home-assistant-streamdeck-yaml/blob/main/configuration.yaml) from the `home-assistant-streamdeck-yaml` repository.

# Usage 🕹️

Once you have installed and configured the add-on, it will automatically run and display your configured buttons on your Stream Deck.

## Support and Issues 🆘

If you have any issues or need support, please create an issue on the [GitHub repository](https://github.com/basnijholt/home-assistant-streamdeck-yaml-addon/issues).

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
