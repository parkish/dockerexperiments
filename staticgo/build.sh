#!/bin/sh

set -ex

CONTAINER_PATH=/go/src/github.com/parkish/dockerfun/staticgo

docker run --rm -i \
    -v `pwd`:"${CONTAINER_PATH}" \
    -w "${CONTAINER_PATH}" \
    golang:1.6 \
    ./build_in_container.sh

docker build --no-cache -t staticgo .
rm -f staticgo
