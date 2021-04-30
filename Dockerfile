FROM node 
WORKDIR /webUI
RUN git clone https://github.com/ipfs/ipfs-webui
RUN cd ipfs-webui && npm install && npm --depth 20 update caniuse-lite browserslist && npm run build

FROM ipfs/go-ipfs

RUN mkdir build
# Copy the IPFS webUI build from previous stage
COPY --from=0 /webUI/ipfs-webui/build build

# The setup.sh script is used to setup private IPFS and replaces the default start_ipfs 
# file provided by the ipfs/go-ipfs image 
COPY setup.sh /usr/local/bin/start_ipfs
RUN chmod 0755 /usr/local/bin/start_ipfs

# Enforce private network settings
ENV LIBP2P_FORCE_PNET 1

# The entrypoint (i.e. script.sh) will setup swarm.key, init IPFS, remove all public 
# bootstrap values and start the ipfs daemon
ENTRYPOINT ["/usr/local/bin/start_ipfs"]
