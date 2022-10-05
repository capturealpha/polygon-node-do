#!/bin/bash

TENDERMINT_CONFIG="${DATA_VOLUME}/heimdall/config/config.toml"
HEIMDALL_CONFIG="${DATA_VOLUME}/heimdall/config/heimdall-config.toml"

# Wait for data volume to mount
until [ -d ${DATA_VOLUME} ]
do
    sleep 5
done

# Set firewall rules
sudo iptables-restore ./iptables.rules
sudo service netfilter-persistent save

# Init heimdall
sudo chown -R ${NODE_USER}:${NODE_USER} ${DATA_VOLUME}
mkdir -p ${DATA_VOLUME}/bor
docker-compose run heimdall init --home=/heimdall-home
sudo chown -R ${NODE_USER}:${NODE_USER} ${DATA_VOLUME}/heimdall
sed -i "s#^moniker =.*#moniker = \"${HOSTNAME}\"#g" ${TENDERMINT_CONFIG}
sed -i "s#^laddr = \"tcp://127.0.0.1:26657\"#laddr = \"tcp://0.0.0.0:26657\"#g" ${TENDERMINT_CONFIG}
sed -i "s#^seeds =.*#seeds = \"${HEIMDALL_SEEDS}\"#g" ${TENDERMINT_CONFIG}
sed -i "s#^persistent_peers =.*#persistent_peers = \"${HEIMDALL_SEEDS}\"#g" ${TENDERMINT_CONFIG}
sed -i "s#^prometheus =.*#prometheus = true#g" ${TENDERMINT_CONFIG}
sed -i "s#^max_open_connections =.*#max_open_connections = 100#g" ${TENDERMINT_CONFIG}
sed -i "s#^chain = .*#chain = \"${POLYGON_NETWORK_NAME}\"#g" ${HEIMDALL_CONFIG}
sed -i "s#^eth_rpc_url =.*#eth_rpc_url = \"${ETH_RPC_URL}\"#g" ${HEIMDALL_CONFIG}
sed -i "s#^bor_rpc_url =.*#bor_rpc_url = \"http://bor:8545\"#g" ${HEIMDALL_CONFIG}
curl -Lso ${DATA_VOLUME}/heimdall/config/genesis.json https://raw.githubusercontent.com/maticnetwork/launch/master/${POLYGON_NETWORK_CODE}/without-sentry/heimdall/config/genesis.json

# Init bor
mkdir -p ${DATA_VOLUME}/bor/bor/chaindata
curl -Lso ${DATA_VOLUME}/bor/genesis.json https://raw.githubusercontent.com/maticnetwork/launch/master/${POLYGON_NETWORK_CODE}/without-sentry/bor/genesis.json
docker-compose run bor --datadir /bor-home init /bor-home/genesis.json
sudo chown -R ${NODE_USER}:${NODE_USER} ${DATA_VOLUME}/bor

# Init caddy
mkdir -p ${DATA_VOLUME}/caddy/config
mv ./Caddyfile ${DATA_VOLUME}/caddy/config
echo "CADDY_PASSWORD_HASH=$(docker-compose run caddy caddy hash-password --plaintext ${CADDY_PASSWORD} | tail -1)" \
| sudo tee -a /etc/environment

# Download snapshots
screen -S chaindata-restore -d -m ./chaindata-restore.sh
sleep 10
