#!/bin/bash

NODEJS_CONTAINER_NAME='nodejs'
OPENJDK_CONTAINER_NAME='jdk'
MAVEN_CONTAINER_NAME='maven'

DEV_LIST=(${PYTHON_CONTAINER_NAME}, ${NODEJS_CONTAINER_NAME}, ${MAVEN_CONTAINER_NAME})

# NODEJS
nodejs () {
    docker run -it --rm \
    -p 5000:5000 \
    --name ${NODEJS_CONTAINER_NAME}-${1} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    node:${1}-alpine \
    sh
}

# PYTHON
# https://hub.docker.com/_/python

PYTHON_TAG='python'
python () {
    docker run -it \
    --rm \
    --name ${PYTHON_TAG}-${1} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    ${PYTHON_TAG}:${1} \
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

# JDK
openjdk () {
    docker run -it \
    --rm \
    --name ${OPENJDK_CONTAINER_NAME}-${1} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    openjdk:${1}-jdk-slim \
    bash
}

# GOLANG
# https://hub.docker.com/_/golang

GO_TAG='golang'
go () {
    docker run -it \
    --rm \
    --name ${GO_TAG}-${1} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    ${GO_TAG}:${1} \
    sh
}
