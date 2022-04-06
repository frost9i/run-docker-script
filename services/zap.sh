#!/bin/bash

ZAP_CONTAINER_NAME='zap'

# ZAP SUB-MENU
submenu_zap () {
    HEADING='ZAP Controls'
    heading_run ${HEADING}
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') zap; ${FUNCNAME[0]};;
        '2') docker exec -it "${ZAP_CONTAINER_NAME}" bash; ${FUNCNAME[0]};;
        '3') zap_init; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${ZAP_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then  docker_container_delete ${ZAP_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Qq]*) submenu_security;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
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
