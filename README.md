# private-ipfs-docker

# 1. Docker Image

The precompiled docker image is available for download at https://hub.docker.com/r/newo/private-ipfs-node

Alternatively, if you wish to manually build the Docker file, simply run:

```
docker build -t private-ipfs-node .
```

# 2. Run Container

To run the image (this can be ran *n* times to create *n* peers for the private network):
```
docker run -d -e SWARM_KEY="8981939525395dc0ed49ffc8c9d2e91b6e23bb591ccc53762e8a4e83946d5f53" newo/private-ipfs-node
```

The SWARM_KEY given above is only an example. You should generate your own swarm key using  [Kubuxu /go-ipfs-swarm-key-gen ](https://github.com/Kubuxu/go-ipfs-swarm-key-gen "Kubuxu /go-ipfs-swarm-key-gen ") or directly in a Bash terminal using the following script [1]:

```
echo -e "/key/swarm/psk/1.0.0/\n/base16/\n`tr -dc 'a-f0-9' < /dev/urandom | head -c64`"
```

When the Bash script is ran, the output will look similar to below:

```
/key/swarm/psk/1.0.0/
/base16/
8981939525395dc0ed49ffc8c9d2e91b6e23bb591ccc53762e8a4e83946d5f53
```

Copy the the *third* line (the key value) and pass it to the ```-e SWARM_KEY``` flag when running the image. All nodes need to use the same key in order to communicate with each other in the private IPFS network.

## 2.1. Note on the (lack of) Bootstrap Node
No Bootstrap node configuration exists in this image as it is assumed all peers (Docker containers in this case) will reside on the same LAN. As described in the IPFS documentation [2], the MDNS protocol is used for local peer discovery in such scenarios. 

# References

[1] van Laar, S. (2019). Deploy a private IPFS network in 5 steps. Retrieved April 16, 2021, from https://medium.com/@s_van_laar/deploy-a-private-ipfs-network-on-ubuntu-in-5-steps-5aad95f7261b

[2] Protocol Labs. (2021). js-ipfs/CONFIG.md at master · ipfs/js-ipfs · GitHub. Retrieved May 24, 2021, from https://github.com/ipfs/js-ipfs/blob/master/docs/CONFIG.md#mdns
