#!/bin/bash

DSECRETS_CONTAINER_NAME='dsecrets'

dsecrets () {
    docker run -it --rm \
    -v "${DOCKER_MY_HOME}/git:/git" \
    --name ${DSECRETS_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    python:3.10-slim bash -c 'apt-get update && apt-get install -y git && pip install detect-secrets && bash'
}
