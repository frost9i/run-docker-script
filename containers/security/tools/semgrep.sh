#!/bin/bash

SEMGREP_CONTAINER_NAME='semgrep'

semgrep () {
    docker run -it \
    ${DOCKER_MOUNT_DIR} \
    --rm \
    --name ${SEMGREP_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v ${DOCKER_MY_HOME}/git:/git \
    returntocorp/semgrep bash
}
