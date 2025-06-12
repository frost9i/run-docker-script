#!/bin/bash

CDXGEN_CONTAINER_NAME='cdxgen'

cdxgen () {
    docker run -it \
    ${DOCKER_MOUNT_DIR} \
    --rm \
    --name ${CDXGEN_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v ${DOCKER_MY_HOME}/git:/git \
    node:22-alpine sh -c 'apk add git bash && npm install -g @cyclonedx/cdxgen@11.0.10 && bash'
    # node:lts-alpine sh -c 'apk add git bash && npm install -g @cyclonedx/cdxgen && bash'
}
