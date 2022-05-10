#!/bin/bash

PYTHON_CONTAINER_NAME='python'
NODEJS_CONTAINER_NAME='nodejs'

DEV_LIST=(${PYTHON_CONTAINER_NAME}, ${NODEJS_CONTAINER_NAME})

nodejs18 () {
    docker run -it \
    --rm \
    --name "${NODEJS_CONTAINER_NAME}-17" \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/home/git" \
    node:18-slim sh
}

nodejs17 () {
    docker run -it \
    --rm \
    --name "${NODEJS_CONTAINER_NAME}-17" \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/home/git" \
    node:17-slim sh
}

nodejs11 () {
    docker run -it \
    --rm \
    --name "${NODEJS_CONTAINER_NAME}-11" \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/home/git" \
    node:11-slim sh
}

python () {
    docker run -it \
    --rm \
    --name ${PYTHON_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/home/git" \
    python:3.7-alpine sh
}
