#!/bin/bash

DEBIAN_CONTAINER_NAME='debian'

debian () {
    if script_ask 'MOUNT EXTERNAL FOLDERS?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/debian:/home/debian -v ${DOCKER_MY_HOME}/git:/git"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker run -it --rm \
    --name ${DEBIAN_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    ${DOCKER_MOUNT_DIR} \
    debian bash
}
