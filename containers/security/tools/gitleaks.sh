#!/bin/bash

GITLEAKS_CONTAINER_NAME='gitleaks'

gitleaks () {
    docker run -it --rm \
    --entrypoint bash \
    -v "${DOCKER_MY_HOME}/git:/git" \
    --name ${GITLEAKS_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    zricethezav/gitleaks
}
