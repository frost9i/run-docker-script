#!/bin/bash

# https://hub.docker.com/_/alpine

ALPINE_CONTAINER_NAME='alpine'

alpine () {
    docker run -it --rm \
    --name ${ALPINE_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    alpine sh
}

alpine_sshd () {
    docker run -it --rm \
    --env ROOT_PASSWORD='pass' \
    -p 22022:22 \
    --env SSH_USERS="user:1000:1000" \
    --volume ${DOCKER_MY_HOME}/ssh:/conf.d/authorized_keys/user \
    --entrypoint bash \
    --name ${ALPINE_CONTAINER_NAME}-sshd \
    --network ${DOCKER_NETWORK_NAME} \
    hermsi/alpine-sshd
}
