#!/bin/bash

DEBIAN_CONTAINER_NAME='debian'

debian () {
    if script_ask 'MOUNT EXTERNAL FOLDERS?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/debian:/home/debian -v ${DOCKER_MY_HOME}/git:/git"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker run -it --rm ${DOCKER_MOUNT_DIR} \
    --name ${DEBIAN_CONTAINER_NAME} \
    -p 5500:5500 -p 3001:3001 \
    debian bash
}

debian_init () {
    if script_ask 'MOUNT EXTERNAL FOLDER TO /tmp/debian ?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/debian:/tmp/debian"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker run -it -d ${DOCKER_MOUNT_DIR} \
    --name ${DEBIAN_CONTAINER_NAME} \
    debian
}
