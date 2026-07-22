# Signal API Receiver

Bridges a [signal-cli-rest-api](https://github.com/bbernhard/signal-cli-rest-api) instance running in
`json-rpc` mode (where `/v1/receive` is only available over WebSocket) into a simple, pollable HTTP
endpoint. Packaged from [kalbasit/signal-api-receiver](https://github.com/kalbasit/signal-api-receiver).

## Prerequisites

A `signal-cli-rest-api` instance already running in `json-rpc` mode, reachable from Home Assistant
over the network (e.g. another add-on, or a container on your LAN).

## Configuration

| Option | Required | Default | Description |
|---|---|---|---|
| `signal_account` | yes | | Signal phone number of the bot account, e.g. `+31612345678` |
| `signal_api_url` | yes | | WebSocket URL to `signal-cli-rest-api`, e.g. `ws://192.168.1.2:8080` |
| `log_level` | no | `info` | `trace`, `debug`, `info`, `warn`, `error`, `fatal`, `panic` |
| `server_addr` | no | `:8105` | Listen address. Change the exposed port too if you change this. |
| `repeat_last_message` | no | `false` | Return the last message again on `/receive/pop` instead of `204` when empty |
| `record_message_type` | no | `data-message` | One of `receipt`, `typing`, `data`, `data-message`, `sync` |
| `mqtt_server` | no | | Optional MQTT broker `host:port`; leave empty to disable MQTT entirely |
| `mqtt_client_id` | no | | |
| `mqtt_user` | no | | |
| `mqtt_password` | no | | |
| `mqtt_topic_prefix` | no | `signal-api-receiver` | |
| `mqtt_qos` | no | `1` | `0`, `1` or `2` |
| `mqtt_retain` | no | `false` | |
| `mqtt_insecure_skip_verify` | no | `false` | |

## Using the API

```
GET http://homeassistant.local:8105/receive/pop
```

Returns `204 No Content` when there is nothing new, or `200 OK` with a JSON body such as:

```json
{
  "account": "+15550100000",
  "envelope": {
    "source": "+15550100001",
    "sourceNumber": "+15550100001",
    "sourceName": "Jane Doe",
    "timestamp": 1784716295530,
    "dataMessage": {
      "message": "Test!"
    }
  }
}
```

Poll this from Home Assistant with a `rest` or `command_line` sensor, or an automation trigger.

## Notes

- Only `amd64` and `aarch64` are supported. Upstream does not publish `armv7` builds
  (confirmed via their release CI and Docker Hub image manifest), so this add-on doesn't
  advertise it either.
- `record_message_type` is only configurable via a startup flag upstream (there is no
  corresponding environment variable), so the add-on always passes it as
  `--record-message-type=<value>` regardless of how you set the option.
