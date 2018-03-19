#!/bin/bash

DELAY=10

export ARCH=`uname -m`

docker-compose -f docker-compose-pc2.yml up -d

sleep $DELAY

docker network create --attachable --driver overlay asclepeion-net
docker network connect asclepeion-net peer2.org1.example.com
docker network connect asclepeion-net peer3.org1.example.com
docker network connect asclepeion-net  couchdb2
docker network connect asclepeion-net  couchdb3

