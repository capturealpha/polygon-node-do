#!/bin/bash

source get_snapshot_url.sh

wget -O- "$(get_snapshot_url ${POLYGON_NETWORK_NAME} "" heimdall)" | tar -xz -C /mnt/data/heimdall/data
wget -O- "$(get_snapshot_url ${POLYGON_NETWORK_NAME} ${BOR_MODE} bor)" | tar -xz -C /mnt/data/bor/bor/chaindata

# Restore permissions to data dir
sudo chown -R root:root /mnt/data

# Start services
docker-compose up -d