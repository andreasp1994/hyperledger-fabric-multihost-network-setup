#!/bin/bash
cp crypto_material/crypto-config/peerOrganizations/org1.example.com/users/Admin\@org1.example.com/msp/signcerts/Admin\@org1.example.com-cert.pem Admin\@org1.example.com-cert.pem

cp crypto_material/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/keystore/d23867d612a7070992ff485b0534b7a269ca8b7b77c5e73a3f9af3eb49d88fbd_sk admin_secret_key

composer card create -p connection_setup2.json -u PeerAdmin -c Admin@org1.example.com-cert.pem -k admin_secret_key -r PeerAdmin -r ChannelAdmin

composer card import -f PeerAdmin@setup1.card

composer runtime install -c PeerAdmin@setup1 -n asclepeion-network

composer network start --card PeerAdmin@setup1 -l INFO --networkAdmin admin --networkAdminEnrollSecret adminpw --archiveFile asclepeion-network.bna --file networkadmin.card

composer card import --file networkadmin.card

composer network ping -c admin@asclepeion-network

composer transaction submit -c admin@asclepeion-network -d '{"$class":"io.asclepeion.network.SetupDemo"}'