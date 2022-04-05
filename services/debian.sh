#!/bin/bash

DEBIAN_CONTAINER_NAME='debian'

# DEBIAN SUB-MENU
submenu_debian () {
    HEADING='DEBIAN Controls'
    heading_run ${HEADING}
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') debian; ${FUNCNAME[0]};;
        '2') docker exec -it ${DEBIAN_CONTAINER_NAME} bash; ${FUNCNAME[0]};;
        '3') debian_init; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${DEBIAN_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) docker_container_delete ${DEBIAN_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Qq]*) submenu_devops;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

debian () {
    if script_ask 'MOUNT EXTERNAL FOLDER TO /tmp/debian ?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/debian:/tmp/debian"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker run -it --rm ${DOCKER_MOUNT_DIR} \
    --name ${DEBIAN_CONTAINER_NAME} \
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
