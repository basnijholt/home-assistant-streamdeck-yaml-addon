# [Home Assistant Stream Deck YAML Add-on](https://github.com/basnijholt/home-assistant-streamdeck-yaml) 🎮

This add-on allows you to control your Home Assistant instance via a Stream Deck, making it easier than ever to manage your smart home devices and scenes 🏠.
The add-on is highly customizable and configured using YAML files.
It runs on the same machine as Home Assistant and supports Linux-based supervised Home Assistant installations.
Check out the [GitHub repository](https://github.com/basnijholt/home-assistant-streamdeck-yaml) for more details.

[![Open this add-on in your Home Assistant instance.][addon-badge]][addon]

## Features :star:
- Easy to use 😄
- Highly customizable 🔧
- Runs on the same machine as Home Assistant 🏠
- Supports Linux-based supervised Home Assistant installations 🐧
- YAML configuration 📁
- Template support for advanced customization 🔥
- Automatically syncs state of `entity_id` to turn display on/off 💤

https://user-images.githubusercontent.com/6897215/229247557-3f0a1dab-d9aa-4aa9-a262-74a27134aa88.mp4

## Installation :package:

To install the add-on, follow these steps:

1. Click the Home Assistant "My ADD-ON" button below to open the add-on on your Home
   Assistant instance.

   [![Open this add-on in your Home Assistant instance.][addon-badge]][addon]

2. Install the `home-assistant-streamdeck-yaml` add-on.

or

1. Go to Supervisor -> Add-on store -> Add new repository by URL and fill in `https://github.com/basnijholt/home-assistant-streamdeck-yaml-addon`.
2. Install the `home-assistant-streamdeck-yaml` add-on.

## Add-on Configuration :gear:

There are two ways to configure the add-on:

### Option 1: Using individual configuration parameters

Depending on your setup, the required configuration parameters may vary:

#### Connecting to Home Assistant on the **same machine** as the add-on:

```yaml
streamdeck_config: /config/streamdeck.yaml
```

#### Connecting to Home Assistant on a **different machine**:

```yaml
streamdeck_config: /config/streamdeck.yaml
websocket_protocol: wss
hass_host: 192.168.1.2
hass_token: YOUR_LONG_LIVED_ACCESS_TOKEN
```

The configuration file includes the following parameters:

- 📄 `streamdeck_config`: The path to your Stream Deck configuration YAML file.
- 🔒 `websocket_protocol`: The WebSocket protocol to use (`ws` for unsecured, `wss` for secured).
- 🏠 `hass_host` (optional): The IP address of your Home Assistant instance. If not provided, the add-on will automatically use the IP address of the host running the add-on.
- 🔑 `hass_token` (optional): The long-lived access token for your Home Assistant instance. If not provided, the add-on will automatically use the Supervisor API token.

### Option 2: Using a `.env` file for configuration

An example add-on configuration using a `.env` file is shown below:

```yaml
streamdeck_dotenv: /config/streamdeck.env
```

The configuration file includes the following parameter:

- `streamdeck_dotenv`: The path to your `.env` file containing the necessary configuration values (e.g., `HASS_HOST`, `HASS_TOKEN`, `STREAMDECK_CONFIG`, and `WEBSOCKET_PROTOCOL`).

⚠️ Note that when specifying an `.env` file, you must include all of the configuration parameters in the `.env` file, and all the other configuration parameters are ignored.
Refer to the [`.env` file example](https://github.com/basnijholt/home-assistant-streamdeck-yaml/blob/main/.env.example) for more details.

## Stream Deck Configuration :video_game:

Create a `configuration.yaml` file for your Stream Deck buttons following the [example configuration](https://github.com/basnijholt/home-assistant-streamdeck-yaml/blob/main/configuration.yaml) from the `home-assistant-streamdeck-yaml` repository.

# Usage 🕹️

Once you have installed and configured the add-on, it will automatically run and display your configured buttons on your Stream Deck.

## Support and Issues :sos:

If you have any issues or need support, please create an issue on the [GitHub repository](https://github.com/basnijholt/home-assistant-streamdeck-yaml-addon/issues).

## License :page_with_curl:

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

[addon-badge]: https://my.home-assistant.io/badges/supervisor_addon.svg
[addon]: https://my.home-assistant.io/redirect/supervisor_addon/?addon=dc473884_home-assistant-streamdeck-yaml&repository_url=https%3A%2F%2Fgithub.com%2Fbasnijholt%2Fhome-assistant-streamdeck-yaml-addon
