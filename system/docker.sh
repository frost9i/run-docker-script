#!/bin/bash

docker_check () {
    if ! docker ps 2>&1 1>/dev/null
    then
        error1 'Docker daemon is not running'
        textbluelight '[!] Start Docker manually and restart this script.'
        exit 1
    fi
    check1 'System check PASSED.'
}

docker_home_check () {
    if [ -z $DOCKER_MY_HOME ]
    then
        textred '[WARNING] $DOCKER_MY_HOME is not set.'
        textred '[WARNING] This will break the script.'
        textred '[WARNING] Please define variable and restart script'
        if script_ask 'Exit?'
        then
            echo ''
            exit
        fi
    else
        check1 "DOCKER_MY_HOME=${DOCKER_MY_HOME}"
    fi
}

docker_network () {
    if ! docker network ls --format '{{ .Name}}' | grep -i ${DOCKER_NETWORK_NAME} > /dev/null
    then
        check1 "DOCKER_NETWORK_NAME=${DOCKER_NETWORK_NAME}"
        docker network create ${DOCKER_NETWORK_NAME} > /dev/null
    fi
    info1 "DOCKER_NETWORK_NAME=${DOCKER_NETWORK_NAME}"
}

docker_ask_port () {
    echo ''
    info1 "PRE-SET PORT ${1}:${2}"
    read -p "[PRESS] EXPOSE PORT for ${1}? [1024-65535]: " -r
    if [[ ${REPLY} =~ ^[0-9]+$ ]]
    then
        if [[ ${REPLY} -gt 1024 && ${REPLY} -lt 65535 ]]
        then
            CONTAINER_EXPOSED_PORT=${REPLY}
            info1 "${1}:${CONTAINER_EXPOSED_PORT}"
            echo ''
            return 0
        fi
        error1 "WRONG PORT: ${REPLY}"
        docker_ask_port ${1} ${2}
    elif [[ -z ${REPLY} ]]
    then
        CONTAINER_EXPOSED_PORT=${2}
        info1 "${1}:${CONTAINER_EXPOSED_PORT}"
        return 0
    fi
    error1 "NOT A PORT."
    docker_ask_port ${1} ${2}
}

docker_stop () {
    if ! docker ps -q | xargs docker stop 2>/dev/null
    then
        error1 'No containers were up.'
    fi
    textmagenta '[STOP] DONE.'

}

docker_container_status () {
    for CONTAINER in ${@}
    do
        if docker_container_check ${CONTAINER}
        then
            if docker ps --format "{{ .Names}}" | grep -i ${CONTAINER} >> /dev/null
            then
                textgreen "[STATUS] ${CONTAINER} RUNNING."
            else
                textgrey "[STATUS] ${CONTAINER} STOPPED."
            fi
        fi
    done
}

docker_container_check () {
    if docker ps -a --format "{{ .Names}}" | grep -i ${1} >> /dev/null
    then
        info1 "${1} OK."
        return 0
    else
        info1 "${1} DOES NOT EXIST."
        return 1
    fi
}

docker_container_create () {
    if ! docker_container_check "${1}"
    then
        textgrey "Creating ${1}"
        if ${2}
        then
            textgreen "[CREATE] SUCCESS."
        fi
    else
        skip1 "${1}"
    fi
}

docker_container_delete () {
    echo ''
    for CONTAINER in ${@}
    do
        textgrey "[DELETE] ${CONTAINER}"
        if docker_container_check ${CONTAINER}
        then
            if docker rm -f ${CONTAINER} > /dev/null
            then
                textred "[DELETE] DONE."
            fi
        fi
    done
}

docker_container_start () {
    for CONTAINER in ${@}
    do
        if docker_container_check ${CONTAINER}
        then
            textgrey "[START] ${CONTAINER}"
            if docker start ${CONTAINER} > /dev/null
            then
                textgreen "[START] SUCCESS."
            else
                fail1 "START ${CONTAINER}"
            fi
        fi
    done
}

docker_container_stop () {
    for CONTAINER in ${@}
    do
        if docker_container_check ${CONTAINER}
        then
            textgrey "[STOP] ${CONTAINER}"
            if docker stop ${CONTAINER} > /dev/null
            then
                textmagenta "[STOP] DONE."
            fi
        fi
    done
}

docker_container_restart () {
    if docker_container_status ${1}
    then
        textgrey "[RESTART] ${1}"
        if docker restart "${1}" > /dev/null
        then
            textyellow "[RESTART] SUCCESS."
        fi
        error1
    fi
}

docker_image_check () {
    if docker images --format "{{ .Repository}}" | grep -i ${1} >> /dev/null
    then
        info1 "${1} IMAGE AVAILABLE."
        return 0
    fi
    info1 "${1} IMAGE DOES NOT EXIST."
    return 1
}

docker_image_build () {
    if ! docker_image_check ${2}
    then
        if docker build -f dockerfiles/${1} -t ${2}:local .
        then
            info1 "${2} BUILD SUCCESS."
            return 0
        fi
        error1 "${2} BUILD FAILED."
        return 1
    fi
}
