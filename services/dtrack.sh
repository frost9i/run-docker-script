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
    HEADING='DEPENDENCY-TRACK Controls'
    heading_run ${HEADING}
    read -p ">> ${HEADING}: " -r
    case ${REPLY} in
        '1') docker_container_start ${DT_LIST[@]}; ${FUNCNAME[0]};;
        '2') docker_container_stop ${DT_LIST[@]}; ${FUNCNAME[0]};;
        '3') dt_init; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${DT_LIST[@]}; ${FUNCNAME[0]};;
        [Dd]*) docker_container_delete ${DT_LIST[@]}; ${FUNCNAME[0]};;
        [Qq]*) submenu_security;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

dt_init () {
    psql_check

    psql_db_create "${DT_PSQL_DATABASE}"

    if script_ask 'MOUNT EXTERNAL /data FOLDER?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/dtrack-api:/data"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker_ask_port "${DT_CONTAINER_API}" "${DT_API_PORT}"
    DT_API_PORT="${CONTAINER_EXPOSED_PORT}"

    if docker_container_create "${DT_CONTAINER_API}" dt_api
    then
        echo -e "[INIT] ${DT_CONTAINER_API} SUCCESS."
    fi

    docker_ask_port "${DT_CONTAINER_FE}" "${DT_FE_PORT}"

    if docker_container_create "${DT_CONTAINER_FE}" dt_fe
    then
        echo -e "[INIT] ${DT_CONTAINER_FE} SUCCESS."
        info1 "DEPENDENCY-TRACK URL: http://localhost:${CONTAINER_EXPOSED_PORT}"
        info1 "DEFAULT LOGIN:admin PASSWORD:admin"
        echo ''
        return
    fi
    error1 "DEPENDENCY-TRACK INIT"
}

dt_api () {
    docker run -d ${DOCKER_MOUNT_DIR} \
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
    docker run -d ${1} \
    -p "${CONTAINER_EXPOSED_PORT}":8080 \
    --name "${DT_CONTAINER_FE}" \
    --network "${DOCKER_NETWORK_NAME}" \
    -e API_BASE_URL="http://localhost:${DT_API_PORT}" \
    dependencytrack/frontend:latest
}

# Reference: https://docs.dependencytrack.org/getting-started/configuration/
