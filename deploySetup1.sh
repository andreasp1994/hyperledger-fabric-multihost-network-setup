#!/bin/bash

DELAY=5

docker-compose -f docker-compose-pc1.yml up -d

sleep $DELAY

docker network create --attachable --driver overlay asclepeion-net
docker network connect asclepeion-net peer0.org1.example.com
docker network connect asclepeion-net  couchdb
docker network connect asclepeion-net ca.org1.example.com
docker network connect asclepeion-net orderer.example.com

docker exec peer0.org1.example.com peer channel create -o orderer.example.com:7050 -c mychannel -f /etc/hyperledger/configtx/channel.tx

# Join peer0.org1.example.com to the channel.
docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/peer/msp" peer0.org1.example.com peer channel join -b mychannel.block
