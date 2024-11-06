#!/bin/bash

CDXGEN_CONTAINER_NAME='cdxgen'

cdxgen () {
    DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/git:/git"

    docker run -it \
    ${DOCKER_MOUNT_DIR} \
    --rm \
    --name ${CDXGEN_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    node:lts-alpine sh -c 'apk add git bash && npm install -g @cyclonedx/cdxgen && bash'
}
