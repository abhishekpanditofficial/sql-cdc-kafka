#!/usr/bin/env bash


script_dir="${BASH_SOURCE%/*}"
config_file="$script_dir/../config.json"
payload=$(<"$config_file")

# Make the curl request with the payload data
curl -i -X PUT -H "Content-Type: application/json" \
  http://localhost:8083/connectors/source-debezium-sqlserver/config \
  -d "$payload"
