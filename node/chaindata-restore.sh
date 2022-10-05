#!/bin/bash
set -o allexport
source /etc/environment
source get_snapshot_url.sh
set +o allexport

wget -O- "$(get_snapshot_url ${POLYGON_NETWORK_NAME} "" heimdall)" | tar -xz -C ${DATA_VOLUME}/heimdall/data
wget -O- "$(get_snapshot_url ${POLYGON_NETWORK_NAME} ${BOR_MODE} bor)" | tar -xz -C ${DATA_VOLUME}/bor/bor/chaindata

# Restore permissions to data dir
sudo chown -R root:root ${DATA_VOLUME}

# Start services
docker-compose up -d

#curl -s http://localhost:26657/status | jq -r .result.sync_info.catching_up