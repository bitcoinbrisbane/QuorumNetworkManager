#!/bin/bash
set -u
set -e

geth --datadir Blockchain init quorum-genesis.json &>> /dev/null

NETID=91351

GLOBAL_ARGS="--networkid $NETID --shh --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum --nodiscover"

nohup constellation-node constellation.config &> constellation.log &
sleep 5

PRIVATE_CONFIG=constellation.config nohup geth --datadir Blockchain $GLOBAL_ARGS --rpcport $4 --rpccorsdomain "*" --port $5 --blockmakeraccount $1 --blockmakerpassword "" --singleblockmaker --minblocktime $2 --maxblocktime $3 &> gethNode.log &
sleep 10

echo "[*] Node started"
