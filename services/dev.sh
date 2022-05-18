#!/bin/bash

PYTHON_CONTAINER_NAME='python'
NODEJS_CONTAINER_NAME='nodejs'

DEV_LIST=(${PYTHON_CONTAINER_NAME}, ${NODEJS_CONTAINER_NAME})

nodejs () {
    docker run -it \
    --rm \
    --name "${NODEJS_CONTAINER_NAME}-17" \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/home/git" \
    node:${1}-alpine sh
}

python () {
    docker run -it \
    --rm \
    --name ${PYTHON_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/home/git" \
    python:${1}-alpine sh
}
