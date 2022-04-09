#!/bin/bash

SEMGREP_CONTAINER_NAME='semgrep'

SAST_LIST=(${SEMGREP_CONTAINER_NAME})

# SAST SUB-MENU
submenu_sast () {
    HEADING='SAST MENU'
    echo -ne """
$(textred_bg ">> ${HEADING}")
(1)$(textyellow 'RUN SEMGREP')
(S)$(textred 'STOP ALL')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') docker_container_create ${SEMGREP_CONTAINER_NAME} semgrep; ${FUNCNAME[0]};;
        [Ss]*) docker_container_stop ${SAST_LIST[@]}; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

semgrep () {
    if script_ask 'MOUNT EXTERNAL FOLDER TO /semgrep-agent ?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/semgrep:/semgrep-agent"
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
