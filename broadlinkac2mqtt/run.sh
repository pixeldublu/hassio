#!/usr/bin/with-contenv bashio

python3 -c 'import sys, yaml, json; print(yaml.dump(json.loads(open("/data/options.json").read())))' > /data/config.yaml