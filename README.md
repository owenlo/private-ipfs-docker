# private-ipfs-docker

To build the Docker file:
```
docker build -t private-ipfs-node .
```

To run the image (this can be ran *n* times to create *n* nodes for the private network):
```
docker run -d -e SWARM_KEY="8981939525395dc0ed49ffc8c9d2e91b6e23bb591ccc53762e8a4e83946d5f53" private-ipfs-node
```

The SWARM_KEY given above is only an example. You should generate your own swarm key using  [Kubuxu /go-ipfs-swarm-key-gen ](https://github.com/Kubuxu/go-ipfs-swarm-key-gen "Kubuxu /go-ipfs-swarm-key-gen ") or directly in a Bash terminal using the following script:

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
