#!/bin/bash

TRUFFLEHOG_CONTAINER_NAME='trufflehog'

trufflehog () {
    docker run -it --rm \
    --entrypoint sh \
    ${DOCKER_MOUNT_DIR} \
    --name ${TRUFFLEHOG_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    trufflesecurity/trufflehog
}
