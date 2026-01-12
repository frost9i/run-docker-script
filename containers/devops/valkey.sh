#!/bin/bash

VALKEY_CONTAINER_NAME='valkey'
VALKEY_CONTAINER_VERSION='7-alpine'

redis () {
    docker run \
    -d \
    --rm \
    --name ${VALKEY_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    redis:${VALKEY_CONTAINER_VERSION}
}
