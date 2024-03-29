#!/bin/bash

PYTHON_CONTAINER_NAME='python'
NODEJS_CONTAINER_NAME='nodejs'
OPENJDK_CONTAINER_NAME='jdk'
MAVEN_CONTAINER_NAME='maven'

DEV_LIST=(${PYTHON_CONTAINER_NAME}, ${NODEJS_CONTAINER_NAME}, ${MAVEN_CONTAINER_NAME})

nodejs () {
    docker run -it --rm \
    -p 5000:5000 \
    --name "${NODEJS_CONTAINER_NAME}" \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    node:${1}-alpine \
    sh
}

python () {
    docker run -it \
    --rm \
    --name ${PYTHON_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    python:${1} \
    bash
}

maven () {
    docker run -it \
    --rm \
    --name ${MAVEN_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    maven:latest \
    bash
}

openjdk () {
    docker run -it \
    --rm \
    --name ${OPENJDK_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    openjdk:${1}-jdk-slim \
    bash
}
