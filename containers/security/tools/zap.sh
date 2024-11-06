#!/bin/bash

ZAP_CONTAINER_NAME='zap'

zap () {
    docker run -it --rm \
    --name ${ZAP_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    --volume ${DOCKER_MY_HOME}/git:/git \
    --publish 8080:8080 \
    softwaresecurityproject/zap-stable bash
    # ghcr.io/zaproxy/zaproxy bash
    # --user root \
}
