#!/bin/bash

# https://github.com/GoogleContainerTools/kaniko

KANIKO_IMAGE='gcr.io/kaniko-project/executor:latest'
KANIKO_CONTAINER_NAME='kaniko'

kaniko () {
    docker run -it --rm \
    --name ${KANIKO_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    ${KANIKO_IMAGE}
}
