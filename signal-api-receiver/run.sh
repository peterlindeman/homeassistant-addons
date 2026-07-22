#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

export SIGNAL_ACCOUNT
export SIGNAL_API_URL
export LOG_LEVEL
export SERVER_ADDR

SIGNAL_ACCOUNT="$(bashio::config 'signal_account')"
SIGNAL_API_URL="$(bashio::config 'signal_api_url')"
LOG_LEVEL="$(bashio::config 'log_level')"
SERVER_ADDR="$(bashio::config 'server_addr')"
RECORD_MESSAGE_TYPE="$(bashio::config 'record_message_type')"

if bashio::config.true 'repeat_last_message'; then
    export REPEAT_LAST_MESSAGE=true
fi

# MQTT is entirely optional; only export MQTT_* when a broker is configured so
# the upstream binary's `cmd.IsSet("mqtt-server")` check stays false otherwise.
if bashio::config.has_value 'mqtt_server'; then
    export MQTT_SERVER
    MQTT_SERVER="$(bashio::config 'mqtt_server')"

    if bashio::config.has_value 'mqtt_client_id'; then
        export MQTT_CLIENT_ID
        MQTT_CLIENT_ID="$(bashio::config 'mqtt_client_id')"
    fi

    if bashio::config.has_value 'mqtt_user'; then
        export MQTT_USER
        MQTT_USER="$(bashio::config 'mqtt_user')"
    fi

    if bashio::config.has_value 'mqtt_password'; then
        export MQTT_PASSWORD
        MQTT_PASSWORD="$(bashio::config 'mqtt_password')"
    fi

    if bashio::config.has_value 'mqtt_topic_prefix'; then
        export MQTT_TOPIC_PREFIX
        MQTT_TOPIC_PREFIX="$(bashio::config 'mqtt_topic_prefix')"
    fi

    export MQTT_QOS
    MQTT_QOS="$(bashio::config 'mqtt_qos')"

    if bashio::config.true 'mqtt_retain'; then
        export MQTT_RETAIN=true
    fi

    if bashio::config.true 'mqtt_insecure_skip_verify'; then
        export MQTT_INSECURE_SKIP_VERIFY=true
    fi
fi

bashio::log.info "Starting signal-api-receiver for account ${SIGNAL_ACCOUNT}, bridging ${SIGNAL_API_URL}"

# --record-message-type has no env var equivalent upstream, it must be passed as a flag.
exec /usr/bin/signal-api-receiver serve "--record-message-type=${RECORD_MESSAGE_TYPE}"
