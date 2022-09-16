#!/bin/bash

TENDERMINT_CONFIG="/mnt/data/heimdall/config/config.toml"
HEIMDALL_CONFIG="/mnt/data/heimdall/config/heimdall-config.toml"

# Init heimdall
sudo chown -R ${USER}:${USER} /mnt/data/
mkdir -p /mnt/data/bor
docker-compose run heimdall init --home=/heimdall-home
sudo chown -R ${USER}:${USER} /mnt/data/heimdall
sed -i "s#^moniker =.*#moniker = \"${HOSTNAME}\"#g" ${TENDERMINT_CONFIG}
sed -i "s#^laddr = \"tcp://127.0.0.1:26657\"#laddr = \"tcp://0.0.0.0:26657\"#g" ${TENDERMINT_CONFIG}
sed -i "s#^seeds =.*#seeds = \"${HEIMDALL_SEEDS}\"#g" ${TENDERMINT_CONFIG}
sed -i "s#^persistent_peers =.*#persistent_peers = \"${HEIMDALL_SEEDS}\"#g" ${TENDERMINT_CONFIG}
sed -i "s#^prometheus =.*#prometheus = true#g" ${TENDERMINT_CONFIG}
sed -i "s#^max_open_connections =.*#max_open_connections = 100#g" ${TENDERMINT_CONFIG}
sed -i "s#^chain = .*#chain = \"${POLYGON_NETWORK_NAME}\"#g" ${HEIMDALL_CONFIG}
sed -i "s#^eth_rpc_url =.*#eth_rpc_url = \"${ETH_RPC_URL}\"#g" ${HEIMDALL_CONFIG}
sed -i "s#^bor_rpc_url =.*#bor_rpc_url = \"http://bor:8545\"#g" ${HEIMDALL_CONFIG}
curl -Lso /mnt/data/heimdall/config/genesis.json https://raw.githubusercontent.com/maticnetwork/launch/master/${POLYGON_NETWORK_CODE}/without-sentry/heimdall/config/genesis.json

# Init bor
mkdir -p /mnt/data/bor/bor/chaindata
curl -Lso /mnt/data/bor/genesis.json https://raw.githubusercontent.com/maticnetwork/launch/master/${POLYGON_NETWORK_CODE}/without-sentry/bor/genesis.json
docker-compose run bor --datadir /bor-home init /bor-home/genesis.json
sudo chown -R ${USER}:${USER} /mnt/data/bor

# Download snapshots
screen -S chaindata-restore -d -m ./chaindata-restore.sh
sleep 10