#!/bin/bash

echo "home: $HOME"
echo "user: $(whoami)"

#####################
# create an account #
#####################

PASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1)
echo $PASSWORD > $HOME/.parity-pass

parity account new --password $HOME/.parity-pass

address=0x$(parity account list | awk 'END{print}' | tr -cd '[:alnum:]._-')

################
# create chain #
################


DAPP_PASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1)
 
command="parity: parity -lsync=trace,txqueue=trace,own_tx=trace --reseal-on-txs all --force-sealing --dapps-hosts  all --dapps-interface 0.0.0.0 --dapps-port 8002 --dapps-user user --dapps-pass $DAPP_PASSWORD --author ${address} --unlock ${address} --password $HOME/.parity-pass --datadir=/home/vagrant/data/parity/eth --rpccorsdomain \"*\" --jsonrpc-hosts=all --jsonrpc-interface all >&1 1>>/var/log/parity.log 2>&1"
echo $command >> /etc/goreman/Procfile
#  --force-sealing
