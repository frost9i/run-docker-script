#!/bin/bash

docker_check () {
    if ! docker -v
    then
        echo -e '[ERROR] Docker daemon is not running'
        echo -e '\nStart it manually and restart the script.'
        exit 1
    else
        echo -e '[CHECK] System check PASSED.'
    fi
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
    echo -e '[STOP]'
    if ! docker ps -q | xargs docker stop
    then
        echo -e '[ERROR] No containers were up.'
    fi
    echo -e '[STOP] DONE.'
}

docker_container_check () {
    if docker ps -a --format "{{ .Names}}" | grep -i ${1} >> /dev/null
    then
        return 0
    fi
    error1 "${1} MISSING."
    return 1
}

docker_container_start () {
    if docker_container_check ${1}
    then
        echo -e "[START] ${1}"
        if docker start ${1} > /dev/null
        then
            echo -e "[START] SUCCESS."
            return
        fi
    fi
    fail1 ${1}
}
