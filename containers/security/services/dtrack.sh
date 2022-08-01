#!/bin/bash

# Reference:
# https://docs.dependencytrack.org/getting-started/configuration/
# https://hub.docker.com/r/dependencytrack/apiserver/tags

DT_SERVICE_VERSION='latest'

DT_SERVICE_NAME='dtrack'
DT_PSQL_DATABASE="${DT_SERVICE_NAME}"

DT_API_PORT='8011'
DT_FE_PORT='8010'

DT_CONTAINER_API="${DT_SERVICE_NAME}-api"
DT_CONTAINER_FE="${DT_SERVICE_NAME}-fe"

DT_LIST=("${DT_CONTAINER_API}" "${DT_CONTAINER_FE}")

dt_init () {
    psql_check

    psql_db_create "${DT_PSQL_DATABASE}"

    if script_ask 'MOUNT EXTERNAL FOLDER TO /data ?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/dtrack-data:/data"
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
    -e ALPINE_DATABASE_URL="jdbc:postgresql://${PSQL_CONTAINER_NAME}:${PSQL_CONTAINER_PORT}/${DT_PSQL_DATABASE}" \
    -e ALPINE_DATABASE_USERNAME="${PSQL_ROOT_USER}" \
    -e ALPINE_DATABASE_PASSWORD="${PSQL_ROOT_PASS}" \
    dependencytrack/apiserver:${DT_SERVICE_VERSION}
}

dt_fe () {
    docker run -d ${1} \
    -p "${CONTAINER_EXPOSED_PORT}":8080 \
    --name "${DT_CONTAINER_FE}" \
    --network "${DOCKER_NETWORK_NAME}" \
    -e API_BASE_URL="http://localhost:${DT_API_PORT}" \
    dependencytrack/frontend:${DT_SERVICE_VERSION}

    echo_port
}
