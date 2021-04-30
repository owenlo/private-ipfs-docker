#!/bin/sh

echo "/key/swarm/psk/1.0.0/" >> /data/ipfs/swarm.key 
echo "/base16/" >> /data/ipfs/swarm.key
echo $SWARM_KEY >> /data/ipfs/swarm.key

#Init ipfs and remove all default bootstrap node values
ipfs init
ipfs bootstrap rm --all

#Add the webui build to IPFS and enable rules to allow access to it
ipfs add -r build
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://127.0.0.1:8080", "http://localhost:3000", "http://127.0.0.1:5001"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]'

ipfs daemon
