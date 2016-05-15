#!/bin/sh

set -ex

container_id=$(docker ps | grep "staticgo" | cut -d" " -f 1)
echo "container_id = $container_id"

port=$(docker port $container_id | cut -d"/" -f 1)
echo "port = $port"

# this is the naming format of the env var when you link containers:
#A13CB26FE98A_PORT_8080_TCP_ADDR=172.17.0.2
#A13CB26FE98A_PORT_8080_TCP_PORT=8080

CONTAINER_ADDR=$(echo "$container_id" | tr "[:lower:]" "[:upper:]")
CONTAINER_ADDR+="_PORT_8080_TCP_ADDR"
FULL_ADDR="$CONTAINER_ADDR:8080"

docker run \
    --rm \
    -i \
    "--link=$container_id" busybox sh -c "wget -T 1 \$$FULL_ADDR"
