#!/bin/bash

JENKINS_CONTAINER_NAME='jenkins'
JENKINS_PORT='7000' # 8080

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

    echo_port
}
