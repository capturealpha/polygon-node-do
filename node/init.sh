#!/bin/bash
SEEDS="f4f605d60b8ffaaf15240564e58a81103510631c@159.203.9.164:26656,4fb1bc820088764a564d4f66bba1963d47d82329@44.232.55.71:26656,2eadba4be3ce47ac8db0a3538cb923b57b41c927@35.199.4.13:26656,3b23b20017a6f348d329c102ddc0088f0a10a444@35.221.13.28:26656,25f5f65a09c56e9f1d2d90618aa70cd358aa68da@35.230.116.151:26656"
wget https://github.com/maticnetwork/launch/blob/master/testnet-v4/without-sentry/heimdall/config/genesis.json
docker-compose run heimdalld init \
  --home=/heimdall-home \
  --chain ${POLYGON_CHAIN} \
  --eth_rpc_url ${ETH_RPC_URL} \
  --seed ${SEEDS}