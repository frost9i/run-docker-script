#!/bin/bash

# https://observatory.mozilla.org

# Scanner
# https://github.com/mozilla/http-observatory

# CLI
# https://github.com/mozilla/observatory-cli

# WEB-interface
# https://github.com/mozilla/http-observatory-website

OBS_SERVICE_NAME='httpobs'
OBS_PSQL_DATABASE='http_observatory'

OBS_DOCKERFILE='Dockerfile-httpobs'

OBS_API_PORT='57001'
OBS_WEB_PORT='5500'

OBS_CONTAINER_API="${OBS_SERVICE_NAME}"
OBS_CONTAINER_WEB="${OBS_SERVICE_NAME}-web"
OBS_CONTAINER_CELERY="${OBS_SERVICE_NAME}-celery"

OBS_LIST=("${OBS_CONTAINER_API}" "${OBS_CONTAINER_CELERY}")

obs_init () {
    psql_check

    psql_db_create "${OBS_PSQL_DATABASE}"

    docker_ask_port "${OBS_CONTAINER_API}" "${OBS_API_PORT}"
    DT_API_PORT="${CONTAINER_EXPOSED_PORT}"

    if docker_container_create "${OBS_CONTAINER_API}" httpobs
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

httpobs_api () {
    docker run -d ${DOCKER_MOUNT_DIR} \
    -p "${CONTAINER_EXPOSED_PORT}":8080 \
    --name "${DT_CONTAINER_API}" \
    --network "${DOCKER_NETWORK_NAME}" \
    -e ALPINE_DATABASE_MODE='external' \
    -e ALPINE_DATABASE_DRIVER='org.postgresql.Driver' \
    -e ALPINE_DATABASE_URL="jdbc:postgresql://${PSQL_CONTAINER_NAME}:${PSQL_CONTAINER_PORT}/${DT_PSQL_DATABASE}" \
    -e ALPINE_DATABASE_USERNAME="${PSQL_ROOT_USER}" \
    -e ALPINE_DATABASE_PASSWORD="${PSQL_ROOT_PASS}" \
    httpobs:local
}

httpobs_celery () {
    docker run -d ${DOCKER_MOUNT_DIR} \
    -p "${CONTAINER_EXPOSED_PORT}":8080 \
    --name "${DT_CONTAINER_API}" \
    --network "${DOCKER_NETWORK_NAME}" \
    -e ALPINE_DATABASE_MODE='external' \
    -e ALPINE_DATABASE_DRIVER='org.postgresql.Driver' \
    -e ALPINE_DATABASE_URL="jdbc:postgresql://${PSQL_CONTAINER_NAME}:${PSQL_CONTAINER_PORT}/${DT_PSQL_DATABASE}" \
    -e ALPINE_DATABASE_USERNAME="${PSQL_ROOT_USER}" \
    -e ALPINE_DATABASE_PASSWORD="${PSQL_ROOT_PASS}" \
    httpobs:local
}

httpobs_web () {
    docker run -d ${1} \
    -p "${CONTAINER_EXPOSED_PORT}":8080 \
    --name "${DT_CONTAINER_FE}" \
    --network "${DOCKER_NETWORK_NAME}" \
    -e API_BASE_URL="http://localhost:${DT_API_PORT}" \
    httpobs-web:local
}
