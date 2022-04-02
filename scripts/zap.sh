#!/bin/bash

ZAP_CONTAINER_NAME='zap'

# ZAP SUB-MENU
submenu_zap () {
    local PS3='>>> ZAP Controls: '
    local options=('RUN' 'STOP' 'INIT' 'STATUS' 'DELETE' 'QUIT')
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            'RUN')
                zap
                ;;
            'STOP')
                docker_container_stop "${ZAP_CONTAINER_NAME}"
                ;;
            'INIT')
                zap_init
                ;;
            'STATUS')
                docker_container_status "${ZAP_CONTAINER_NAME}"
                ;;
            'DELETE')
                docker_container_delete "${ZAP_CONTAINER_NAME}"
                ;;
            'QUIT')
                PS3='>> SECURITY Tools: '
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

zap () {
    docker run -it --rm \
    --name ${ZAP_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    owasp/zap2docker-stable bash
}

zap_init () {
    docker run -it -d \
    --name ${ZAP_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    owasp/zap2docker-stable bash
}
