#!/bin/sh

set -ex

run_linked_container_test() {
    container_id=$1
    echo "run container test using linked container"
    
    # this is the naming format of the env var when you link containers:
    #A13CB26FE98A_PORT_8080_TCP_ADDR=172.17.0.2
    #A13CB26FE98A_PORT_8080_TCP_PORT=8080
    linked_addr_env_var=$(echo "$container_id" | tr "[:lower:]" "[:upper:]")
    linked_addr_env_var+="_PORT_8080_TCP_ADDR"
    linked_addr_env_var+=":8080"

    docker run \
        --rm \
        -i \
        "--link=$container_id" busybox sh -c "wget -T 1 \$$linked_addr_env_var"
}

run_from_docker_host() {
    container_id=$1
    docker_assigned_port=$(docker port "$container_id" 8080 | cut -d":" -f 2)
    
    docker run \
        --rm \
        --net=host \
        -i \
        busybox \
        wget -T 1 "http://localhost:$docker_assigned_port"
}

container_id=$(docker ps | grep "staticgo" | cut -d" " -f 1)
echo "container_id = $container_id"

if [ -z "$container_id" ]; then
    echo "No container ID - start the container first using run.sh"
    exit 1
fi

# test hitting the container from within the Docker NAT network and from outside
run_linked_container_test $container_id
run_from_docker_host $container_id

echo "All tests passed"
