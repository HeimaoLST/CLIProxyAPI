#!/bin/sh
set -e

CONFIG=/CLIProxyAPI/config.yaml
TEMPLATE=/CLIProxyAPI/config.template.yaml

# Ensure runtime directories exist
mkdir -p /root/.cli-proxy-api /CLIProxyAPI/logs

# If config.yaml is missing or empty, seed it from the template
if [ ! -s "$CONFIG" ]; then
  echo "[entrypoint] config.yaml is empty — copying template to $CONFIG"
  cp "$TEMPLATE" "$CONFIG"
  echo "[entrypoint] Edit $CONFIG or use the management panel to configure the server."
fi

exec ./CLIProxyAPI "$@"
