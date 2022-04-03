#!/bin/bash

JENKINS_CONTAINER_NAME='jenkins'
JENKINS_PORT='7000' # 8080

submenu_jenkins () {
    local PS3='>>> JENKINS Controls: '
    local options=('START' 'STOP' 'INIT' 'STATUS' 'DELETE' 'QUIT' 'SHOW ADMIN PASSWORD')
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            'START')
                docker_container_start ${JENKINS_CONTAINER_NAME}
                ;;
            'STOP')
                docker_container_stop ${JENKINS_CONTAINER_NAME}
                ;;
            'INIT')
                jenkins_init
                ;;
            'STATUS')
                docker_container_status ${JENKINS_CONTAINER_NAME}
                ;;
            'DELETE')
                docker_container_delete ${JENKINS_CONTAINER_NAME}
                ;;
            'QUIT')
                PS3='>> DEVOPS Tools: '
                return
                ;;
            'SHOW ADMIN PASSWORD')
                docker exec -it -u root ${JENKINS_CONTAINER_NAME} bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

jenkins_init () {
    if script_ask 'MOUNT EXTERNAL /var/jenkins_home FOLDER?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/jenkins:/var/jenkins_home"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker_ask_port "${JENKINS_CONTAINER_NAME}" "${JENKINS_PORT}"

    if docker_container_create "${JENKINS_CONTAINER_NAME}" jenkins_start
    then
        echo -e "[INIT] ${JENKINS_CONTAINER_NAME} SUCCESS."
    fi
}

jenkins_start () {
    docker run -d ${DOCKER_MOUNT_DIR} \
    -p ${CONTAINER_EXPOSED_PORT}:8080 \
    --name ${JENKINS_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    jenkins/jenkins:latest
}
