#!/bin/bash

CLAIR_CONTAINER_NAME='clair'
CLAIR_VERSION='latest'

clair () {
    docker run -it \
    ${DOCKER_MOUNT_DIR} \
    --rm \
    --name ${CLAIR_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v ${DOCKER_MY_HOME}/git:/git \
    quay.io/projectquay/clair:${CLAIR_VERSION} sh
    # https://quay.io/repository/projectquay/clair?tab=tags
}
