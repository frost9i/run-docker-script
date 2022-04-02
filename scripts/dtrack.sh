#!/bin/bash

DT_SERVICE_NAME='dtrack'
DT_PSQL_DATABASE="${DT_SERVICE_NAME}"

DT_API_PORT='8091'
DT_FE_PORT='8090'

DT_CONTAINER_API="${DT_SERVICE_NAME}-api"
DT_CONTAINER_FE="${DT_SERVICE_NAME}-fe"

DT_LIST=("${DT_CONTAINER_API}" "${DT_CONTAINER_FE}")

# DEPENDENCY-TRACK SUB-MENU
submenu_dt () {
    local PS3='>>> DEPENDENCY-TRACK Controls: '
    local options=('START' 'STOP' 'INIT' 'STATUS' '' 'DELETE' 'QUIT')
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            'START')
                dt_start
                ;;
            'STOP')
                dt_stop
                ;;
            'INITIALIZE')
                dt_init
                ;;
            'STATUS')
                dt_status
                ;;
            '')
                submenu_todo
                ;;
            'DELETE')
                dt_delete
                ;;
            'QUIT')
                PS3='>> SECURITY Tools: '
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# database
#-v C:/Users/Sergii_Moroz1/docker/dtrack-api:/data

DT_API_PORT="${CONTAINER_EXPOSED_PORT}"
DT_FE_PORT="${CONTAINER_EXPOSED_PORT}"

dt_init () {
    psql_check

    psql_db_create "${DT_PSQL_DATABASE}"

    if script_ask 'MOUNT EXTERNAL /data FOLDER?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/dtrack-api:/data"
    fi

    docker_ask_port "${DT_CONTAINER_API}" "${DT_API_PORT}"

    if docker_container_create "${DT_CONTAINER_API}" dt_api "${DOCKER_MOUNT_DIR}"
    then
        #
    fi

}

dt_api () {
    docker run -d "${1}" \
    -p "${CONTAINER_EXPOSED_PORT}":8080 \
    --name "${DT_CONTAINER_API}" \
    --network "${DOCKER_NETWORK_NAME}" \
    -e ALPINE_DATABASE_MODE='external' \
    -e ALPINE_DATABASE_DRIVER='org.postgresql.Driver' \
    -e ALPINE_DATABASE_URL="jdbc:postgresql://${PSQL_CONTAINER_NAME}:${PSQL_CONTAINER_PORT}/${DT_SERVICE_NAME}" \
    -e ALPINE_DATABASE_USERNAME="${PSQL_ROOT_USER}" \
    -e ALPINE_DATABASE_PASSWORD="${PSQL_ROOT_PASS}" \
    dependencytrack/apiserver:latest
}

dt_fe () {
    docker run -d "${1}"\
    -p "${CONTAINER_EXPOSED_PORT}":8080 \
    --name "${DT_CONTAINER_FE}" \
    --network "${DOCKER_NETWORK_NAME}" \
    -e API_BASE_URL="http://localhost:${DT_API_PORT}" \
    dependencytrack/frontend:latest
}

