#!/bin/bash

### UNDER CONSTRUCTION !!!

# https://observatory.mozilla.org

# Scanner
# https://github.com/mozilla/http-observatory

# CLI
# https://github.com/mozilla/observatory-cli (advanced) for npm
# https://github.com/mozilla/http-observatory-cli (limited) for pip

# WEB-interface
# https://github.com/mozilla/http-observatory-website

OBS_SERVICE_NAME='httpobs'
OBS_PSQL_DATABASE='http_observatory'

OBS_DOCKERFILE="Dockerfile-${OBS_SERVICE_NAME}"

OBS_API_PORT='57001'
OBS_WEB_PORT='5500'

OBS_CONTAINER_API="${OBS_SERVICE_NAME}"
OBS_CONTAINER_WEB="${OBS_SERVICE_NAME}-web"
OBS_CONTAINER_CELERY="${OBS_SERVICE_NAME}-celery"

OBS_LIST=("${OBS_CONTAINER_API}" "${OBS_CONTAINER_CELERY}" "${OBS_CONTAINER_WEB}")

obs_init () {
    psql_check
    psql_db_create "${OBS_PSQL_DATABASE}"

    docker_ask_port "${OBS_CONTAINER_API}" "${OBS_API_PORT}"

    if docker_container_create "${OBS_CONTAINER_API}" httpobs_api
    then
        echo -e "[INIT] ${OBS_CONTAINER_API} SUCCESS."
        info1 "MOZILLA-OBSERVATORY URL: http://localhost:${CONTAINER_EXPOSED_PORT}"
        echo ''
        return
    else
        error1 "MOZILLA-OBSERVATORY INIT"
    fi

    if docker_container_create "${OBS_CONTAINER_CELERY}" httpobs_celery
    then
        init1 "${OBS_CONTAINER_CELERY} SUCCESS."
    fi

    docker_ask_port "${OBS_CONTAINER_WEB}" "${OBS_WEB_PORT}"

    if docker_container_create "${OBS_CONTAINER_WEB}" httpobs_web
    then
        init1 "${OBS_CONTAINER_WEB} SUCCESS."
    fi
}

httpobs_api () {
    docker run -d \
    -p "${CONTAINER_EXPOSED_PORT}":${OBS_API_PORT} \
    --name "${OBS_CONTAINER_API}" \
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
    docker run -d \
    -p "${CONTAINER_EXPOSED_PORT}":"${OBS_WEB_PORT}" \
    --name "${OBS_CONTAINER_WEB}" \
    --network "${DOCKER_NETWORK_NAME}" \
    -e API_BASE_URL="http://localhost:${OBS_WEB_PORT}" \
    node:17-alpine && \
    docker exec && end
}
