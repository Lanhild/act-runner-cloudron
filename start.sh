#!/bin/bash
set -eu

echo "=> Ensure directories"
mkdir -p /app/data/

if [[ ! -f /app/data/config.yaml ]]; then
    echo "=> Generating runner configuration"
    /app/code/act_runner generate-config > /app/data/config.yaml
fi

echo "=> Setting permissions"
chown -R cloudron:cloudron /app/data


if [[ ! -f /app/data/.runner ]]; then
    echo "/!\ Register the runner locally first. /!\\"
else
    echo "==> Starting runner"
    exec gosu cloudron:cloudron /app/code/act_runner -c /app/data/config.yaml daemon
fi
