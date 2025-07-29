#!/bin/bash

SQLPAD_IMAGE='sqlpad/sqlpad:latest'
SQLPAD_CONTAINER_NAME='sqlpad'

sqlpad () {
    docker run -it --rm \
    --name ${SQLPAD_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -p 3000:3000 \
    -e SQLPAD_ADMIN='admin' \
    -e SQLPAD_ADMIN_PASSWORD='pass' \
    -e SQLPAD_APP_LOG_LEVEL='debug' \
    ${SQLPAD_IMAGE}
}
