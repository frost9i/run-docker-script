#!/bin/bash

docker_check () {
    if ! docker ps 2>&1 > /dev/null
    then
        echo -e '[ERROR] Docker daemon is not running'
        echo -e '[USER] Start Docker manually and restart the script.'
        exit 1
    fi
    echo -e '[CHECK] System check PASSED.'
}

docker_home_check () {
    if [ -z $DOCKER_MY_HOME ]
    then
        echo -e '[WARNING] $DOCKER_MY_HOME is not set.'
        echo -e '[WARNING] This will break the script.'
        echo -e '[WARNING] Please define variable and restart script'
        if script_ask 'Exit?'
        then
            echo ''
            exit
        fi
    else
        echo -e "[CHECK] DOCKER_MY_HOME=${DOCKER_MY_HOME}"
    fi
}

docker_network () {
    if ! docker network ls --format '{{ .Name}}' | grep -i ${DOCKER_NETWORK_NAME} > /dev/null
    then
        check1 "DOCKER_NETWORK_NAME=${DOCKER_NETWORK_NAME}"
        docker network create ${DOCKER_NETWORK_NAME} > /dev/null
        return 0
    fi
    info1 "DOCKER_NETWORK_NAME=${DOCKER_NETWORK_NAME}"
}

docker_ask_port () {
    echo ''
    info1 "DEFAULT PORT ${1}:${2}"
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
    echo -e '[STOP] FULL STOP'
    if ! docker ps -q | xargs docker stop 2>/dev/null
    then
        echo -e '[ERROR] No containers were up.'
        return
    fi
    echo -e '[STOP] DONE.'
    return
}

docker_container_status () {
    for CONTAINER in ${@}
    do
        if docker_container_check ${CONTAINER}
        then
            if docker ps --format "{{ .Names}}" | grep -i ${CONTAINER} >> /dev/null
            then
                echo -e "[STATUS] ${CONTAINER} RUNNING."
                return 0
            fi
            echo -e "[STATUS] ${CONTAINER} STOPPED."
            return 1
        fi
        echo -e "[STATUS] MISSING."
    done
}

docker_container_check () {
    if docker ps -a --format "{{ .Names}}" | grep -i ${1} >> /dev/null
    then
        return 0
    fi
    return 1
}

docker_container_create () {
    if ! docker_container_check "${1}"
    then
        echo -e "[CREATE] ${1}"
        if "${2}"
        then
            echo "[CREATE] SUCCESS."
        fi
    else
        skip1 "${1}"
    fi
}

docker_container_delete () {
    for CONTAINER in ${@}
    do
        if docker_container_check ${CONTAINER}
        then
            echo -e "[DELETE] ${CONTAINER}"
            if docker rm -f ${CONTAINER} > /dev/null
            then
                echo "[DELETE] DONE."
            fi
        fi
    done
}

docker_container_start () {
    for CONTAINER in ${@}
    do
        if docker_container_check ${CONTAINER}
        then
            echo -e "[START] ${CONTAINER}"
            if docker start ${CONTAINER} > /dev/null
            then
                echo -e "[START] SUCCESS."
                return 0
            fi
        fi
        fail1 "START ${CONTAINER}"
    done
}

docker_container_stop () {
    for CONTAINER in ${@}
    do
        if docker_container_check ${CONTAINER}
        then
            echo -e "[STOP] ${CONTAINER}"
            if docker stop ${CONTAINER} > /dev/null
            then
                echo -e "[STOP] DONE."
                return 0
            fi
        fi
        fail1 "STOP ${CONTAINER}"
    done
}

docker_container_restart () {
    if docker_container_status ${1}
    then
        if docker restart "${1}" > /dev/null
        then
            echo -e "[RESTART] SUCCESS."
            return
        fi
        error1
    fi
}
