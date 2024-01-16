#!/bin/bash

CLAIR_CONTAINER_NAME='clair'

clair () {
    DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/git:/git"

    docker run -it \
    ${DOCKER_MOUNT_DIR} \
    --rm \
    --name ${CLAIR_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    quay.io/projectquay/clair:4.6.1 sh
    # https://quay.io/repository/projectquay/clair?tab=tags
}
