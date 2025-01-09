#!/bin/bash
set -eu

echo "=> Ensure directories"
mkdir -p /app/data/act

[[ ! -f /app/data/act/config.yaml ]] && cp /app/pkg/config.yaml /app/data/act/config.yaml

echo "==> Update permissions"
chown -R cloudron:cloudron /app/data


if [[ ! -f /app/data/act/.runner ]]; then
    echo "/!\ Register the runner locally first. /!\\"
    exec gosu cloudron:cloudron /app/code/act_runner cache-server -p 8088
else
    echo "==> Starting runner"
    exec gosu cloudron:cloudron /app/code/act_runner -c /app/data/act/config.yaml daemon
fi
