#!/bin/bash

DEPSCAN_CONTAINER_NAME='depscan'

depscan () {
    docker run -it \
    ${DOCKER_MOUNT_DIR} \
    --rm \
    --name ${DEPSCAN_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v ${DOCKER_MY_HOME}/git:/git \
    ghcr.io/owasp-dep-scan/dep-scan bash
}
