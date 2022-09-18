#! /bin/bash

function get_snapshot_url() {
    network="${1}"
    mode="${2}"
    # use pruned snapshot instead of fullnode snapshot with mainnet
    if [ "$mode" == "fullnode" ] && [ "$network" == "mainnet" ] ;then
        mode="pruned"
    fi
    node_type="${3}"
    curl -s https://snapshots.matic.today/ | grep "${network}/${node_type}-${mode}" | cut -f 3 -d '>' | cut -f 1 -d '<'
}
