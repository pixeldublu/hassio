#!/bin/bash
set -e

echo "**** Creating CONFIG ****"

CONFIG_PATH=/data/options.json
MQTT_HOST="$(jq --raw-output '.mqttHost' $CONFIG_PATH)"
MQTT_USER="$(jq --raw-output '.mqttUser' $CONFIG_PATH)"
MQTT_PASS="$(jq --raw-output '.mqttPassword' $CONFIG_PATH)"
AIRCONIP="$(jq --raw-output '.airConIp' $CONFIG_PATH)"
AIRCONMAC="$(jq --raw-output '.airConMac' $CONFIG_PATH)"
AIRCONPORT="$(jq --raw-output '.airConPort' $CONFIG_PATH)"
AIRCONNAME="$(jq --raw-output '.airConName' $CONFIG_PATH)"


cat > /config/config.yml << EOL
service:
    daemon_mode: True
    update_interval: 10
    self_discovery: True
    bind_to_ip: False

mqtt:
    host: ${MQTT_HOST}
    port: 1883
    client_id: ac_to_mqtt
    user: ${MQTT_USER}
    passwd: ${MQTT_PASS}
    topic_prefix: /aircon
    auto_discovery_topic: homeassistant
    auto_discovery_topic_retain: True
    discovery: True

##Devices
devices:
- ip: ${AIRCONIP}
  mac: ${AIRCONMAC}
  name: ${AIRCONNAME}
  port: ${AIRCONPORT}
EOL


python3 /app/ac2mqtt/monitor.py -c /config/config.yml -d

