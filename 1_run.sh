docker rm -f parity-master
docker run --name parity-master -p 8545:8545 -p 30303:30303 -p 8001:8001 -p 8002:8002 -d baseboxorg/docker-parity-master:eth
docker exec -it parity-master 'bash'
