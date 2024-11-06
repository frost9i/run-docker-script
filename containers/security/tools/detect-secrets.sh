#!/bin/bash

DSECRETS_CONTAINER_NAME='detect-secrets'

detect-secrets () {
    docker run -it --rm \
    -v "${DOCKER_MY_HOME}/git:/git" \
    --name ${DSECRETS_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    python:3.12-slim bash -c 'apt-get update && apt-get install -y git && pip install detect-secrets && bash'
}
