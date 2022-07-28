#!/bin/bash

TRUFFLEHOG_CONTAINER_NAME='trufflehog'

trufflehog () {
    docker run -it \
    --entrypoint sh \
    ${DOCKER_MOUNT_DIR} \
    --rm \
    --name ${TRUFFLEHOG_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    trufflesecurity/trufflehog
}
