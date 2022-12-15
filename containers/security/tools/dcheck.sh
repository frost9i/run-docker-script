#!/bin/bash

DCHECK_CONTAINER_NAME='dcheck'

dcheck () {
    docker run -it \
    --rm \
    --entrypoint sh \
    --name ${DCHECK_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    owasp/dependency-check
}
