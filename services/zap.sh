#!/bin/bash

ZAP_CONTAINER_NAME='zap'

# ZAP SUB-MENU
submenu_zap () {
    HEADING='ZAP Controls'
    echo -ne """
$(textyellow_bg ">> ${HEADING}")
1)$(textgreen 'RUN')  2)$(textmagenta 'CONNECT')  3)$(textyellow 'INIT')  4)$(textgreydark 'STATUS')  5)$(textred 'DELETE')  0)$(textgreydark 'ESC')
"""
    read -p ">> ${HEADING}: " -r
    case ${REPLY} in
        '1') zap; ${FUNCNAME[0]};;
        '2') docker exec -it "${ZAP_CONTAINER_NAME}" bash; ${FUNCNAME[0]};;
        '3') zap_init; ${FUNCNAME[0]};;
        '4') docker_container_status ${ZAP_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '5') docker_container_delete ${ZAP_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '0') submenu_security;;
        *)
            echo "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
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
