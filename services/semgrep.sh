#!/bin/bash

SEMGREP_CONTAINER_NAME='semgrep'

semgrep () {
    if script_ask 'MOUNT EXTERNAL GIT FOLDER TO /semgrep-agent ?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/git:/semgrep-agent"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker run -it \
    ${DOCKER_MOUNT_DIR} \
    --rm \
    --name ${SEMGREP_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    returntocorp/semgrep-agent bash
}
