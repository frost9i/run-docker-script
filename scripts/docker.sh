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
    if docker_container_check "${1}"
    then
        if docker ps --format "{{ .Names}}" | grep -i "${1}" >> /dev/null
        then
            echo -e "[STATUS] "${1}" RUNNING."
            return 0
        fi
        echo -e "[STATUS] "${1}" STOPPED."
        return 1
    fi
    error1 "[STATUS]"
}

docker_container_check () {
    if docker ps -a --format "{{ .Names}}" | grep -i ${1} >> /dev/null
    then
        return 0
    fi
    error1 "${1} MISSING."
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

docker_container_start () {
    if docker_container_check ${1}
    then
        echo -e "[START] ${1}"
        if docker start ${1} > /dev/null
        then
            echo -e "[START] SUCCESS."
            return 0
        fi
    fi
    fail1 ${1}
}

docker_container_restart () {
    if docker_container_status
    then
        if docker restart "${1}" > /dev/null
        then
            echo -e "[RESTART] SUCCESS."
            return
        fi
        error1
    fi
}
