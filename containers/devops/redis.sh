#!/bin/bash

REDIS_CONTAINER_NAME='redis'
REDIS_CONTAINER_VERSION='alpine'

redis () {
    docker run \
    -d \
    --rm \
    --name ${REDIS_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    redis:${REDIS_CONTAINER_VERSION}
}
