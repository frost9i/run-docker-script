#!/bin/bash

SYFT_CONTAINER_NAME='syft'

syft () {
    docker run -it \
    --rm \
    --name ${SYFT_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    anchore/syft
}
