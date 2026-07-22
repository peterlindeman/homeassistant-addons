# Add-ons for Home Assistant OS

[![License][license-shield]](LICENSE.md)

## About

This repository collects all of my Hass.io add-ons for easier installation.

## Installation

Follow [the official instructions](https://www.home-assistant.io/common-tasks/os#installing-third-party-add-ons) on the Home Assistant website and use the following URL:
```txt
https://github.com/peterlindeman/homeassistant-addons
```

## Add-ons provided by this repository

### [Signal API Receiver][addon-signal-api-receiver]

![Supports aarch64 Architecture][signal-api-receiver-aarch64-shield]
![Supports amd64 Architecture][signal-api-receiver-amd64-shield]

Polls a `signal-cli-rest-api` json-rpc WebSocket feed and exposes it over a simple pollable
HTTP endpoint. Wraps [kalbasit/signal-api-receiver](https://github.com/kalbasit/signal-api-receiver).

[:books: Signal API Receiver add-on documentation][addon-signal-api-receiver]

[addon-signal-api-receiver]: signal-api-receiver/DOCS.md
[signal-api-receiver-aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg?style=flat
[signal-api-receiver-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg?style=flat
[license-shield]: https://img.shields.io/github/license/danielwelch/hassio-addons.svg?style=flat
