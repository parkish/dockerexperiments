#!/bin/sh

# run the docker container, exposing any of it's port's declared with an EXPOSE directive
# the 'test_with_linked_containers.sh' will find the random external port and connect to it
# for our tests
docker run -it --rm -P staticgo
