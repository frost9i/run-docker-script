#!/bin/bash

DEBIAN_CONTAINER_NAME='debian'

submenu_debian () {
    local PS3='>>> DEBIAN Controls: '
    local options=('RUN' 'CONNECT' 'INIT' 'STATUS' 'DELETE' 'QUIT')
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            'RUN')
                debian
                ;;
            'CONNECT')
                docker exec -it ${DEBIAN_CONTAINER_NAME} bash
                ;;
            'INIT')
                debian_init
                ;;
            'STATUS')
                docker_container_status ${DEBIAN_CONTAINER_NAME}
                ;;
            'DELETE')
                docker_container_delete ${DEBIAN_CONTAINER_NAME}
                ;;
            'QUIT')
                PS3='>> DEVOPS Tools: '
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

debian () {
    if script_ask 'MOUNT EXTERNAL FOLDER to /tmp/debian?'
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
    if script_ask 'MOUNT EXTERNAL FOLDER to /tmp/debian?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/debian:/tmp/debian"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker run -it -d ${DOCKER_MOUNT_DIR} \
    --name ${DEBIAN_CONTAINER_NAME} \
    debian
}
