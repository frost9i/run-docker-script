#!/bin/bash

# https://hub.docker.com/_/alpine

ALPINE_CONTAINER_NAME='alpine'

alpine () {
    docker run \
    -it \
    --rm \
    --name ${ALPINE_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    alpine sh
}
