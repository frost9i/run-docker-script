#!/bin/bash

# source ./scripts/network.sh

PSQL_CONTAINER_NAME='postgres'
PSQL_CONTAINER_PORT='5432'
PSQL_ROOT_USER='pgown'
PSQL_ROOT_PASS='pass'

psql_connect () {
    PGHOST=localhost \
    PGPORT=${PSQL_CONTAINER_PORT} \
    PGDATABASE=${PSQL_ROOT_USER}
    PGUSER=${PSQL_ROOT_USER} \
    PGPASSWORD=${PSQL_ROOT_PASS} \
    psql -c "${1}"
}

psql_db_create () {
    echo -e "[CREATE] DB ${1}"
    if psql_connect "CREATE DATABASE ${1};"
    then
        if psql_connect "GRANT ALL PRIVILEGES ON DATABASE ${1} TO ${2};"
        then
            echo -e "[CREATE] SUCCESS."
            return
        fi
    fi
}

psql_check () {
    echo -e "[CHECK] ${PSQL_CONTAINER_NAME}"
    if ! docker ps -a --format '{{ .Names}}' | grep -i ${PSQL_CONTAINER_NAME} > /dev/null
    then
        error1 'Postgres must be created first'
        if script_ask "Create ${PSQL_CONTAINER_NAME} container?"
        then
            psql_create
            return
        fi
    elif ! docker ps --format '{{ .Names}}' | grep -i ${PSQL_CONTAINER_NAME} > /dev/null
    then
        psql_start
        return
    fi
    echo -e "[PSQL] ${PSQL_CONTAINER_NAME} IS UP."
}

psql_start () {
    echo -e "[START] ${PSQL_CONTAINER_NAME}"
    if docker start ${PSQL_CONTAINER_NAME} > /dev/null
    then
        echo -e '[START] SUCCESS.'
        return
    fi
    error1
}

psql_stop () {
    echo -e "[NOTICE] ${PSQL_CONTAINER_NAME} stopping..."
    if docker stop ${PSQL_CONTAINER_NAME} > /dev/null
    then
        echo -e '[NOTICE] Stopped.'
        return
    fi
    error1
}

psql_create () {
    if docker run -d \
    -p ${PSQL_CONTAINER_PORT}:5432 \
    --name ${PSQL_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -e POSTGRES_USER=${PSQL_ROOT_USER} \
    -e POSTGRES_PASSWORD=${PSQL_ROOT_PASS} \
    postgres:11-buster > /dev/null
    then
        echo -e "[CREATE] ${PSQL_CONTAINER_NAME} created."
        return
    fi
    error1
}

psql_delete () {
    echo "[DELETE] ${PSQL_CONTAINER_NAME}"
    if docker rm -f ${PSQL_CONTAINER_NAME} > /dev/null
    then
        echo '[DELETE] DONE.'
        return
    fi
    error1
}

psql_status () {
    if docker ps -a | grep -i ${PSQL_CONTAINER_NAME} > /dev/null
    then
        echo -e "[STATUS] ${PSQL_CONTAINER_NAME} exists."
    else
        echo -e "[STATUS] ${PSQL_CONTAINER_NAME} does not exist."
    fi

    if docker ps | grep -i ${PSQL_CONTAINER_NAME} > /dev/null
    then
        echo -e "[STATUS] ${PSQL_CONTAINER_NAME} is running."
        psql_connect '\l+'
    else
        echo -e "[STATUS] ${PSQL_CONTAINER_NAME} is stopped."
    fi
}

psql_cli () {
    if ! command -v psql > /dev/null
    then
        echo -e '[CHECK] [FAIL] psql not found.'
        return
    fi
    echo -n '[CHECK] ' && psql --version
}

