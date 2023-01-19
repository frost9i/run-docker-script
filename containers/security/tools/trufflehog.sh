#!/bin/bash

TRUFFLEHOG_CONTAINER_NAME='trufflehog'

trufflehog () {
    docker run -it --rm \
    --entrypoint sh \
    -v "${DOCKER_MY_HOME}/git:/git" \
    --name ${TRUFFLEHOG_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    trufflesecurity/trufflehog
}
