#!/bin/bash

JENKINS_CONTAINER_NAME='jenkins'
JENKINS_PORT='7000' # 8080

# JENKINS SUB-MENU
submenu_jenkins () {
    HEADING='JENKINS Controls'
    heading_srv ${HEADING}
    textgreydark "(P)SHOW INIT ADMIN PASSWORD"
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') docker_container_start ${JENKINS_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '2') docker_container_stop ${JENKINS_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '3') jenkins_init && submenu_jenkins;;
        [Ss]*) docker_container_status ${JENKINS_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) docker_container_delete ${JENKINS_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Pp]*) if docker exec -it -u root ${JENKINS_CONTAINER_NAME} bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"; then echo ''; fi; ${FUNCNAME[0]};;
        [Qq]*) submenu_devops;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

jenkins_init () {
    if script_ask 'MOUNT EXTERNAL FOLDER TO /var/jenkins_home ?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/jenkins:/var/jenkins_home"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker_ask_port "${JENKINS_CONTAINER_NAME}" "${JENKINS_PORT}"

    if docker_container_create "${JENKINS_CONTAINER_NAME}" jenkins_start
    then
        init1 "${JENKINS_CONTAINER_NAME} SUCCESS."
    fi
}

jenkins_start () {
    docker run -d ${DOCKER_MOUNT_DIR} \
    -p ${CONTAINER_EXPOSED_PORT}:8080 \
    --name ${JENKINS_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    jenkins/jenkins:latest
}
