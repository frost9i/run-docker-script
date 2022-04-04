#!/bin/bash

PSQL_CONTAINER_NAME='postgres'
PSQL_CONTAINER_PORT='5432'
PSQL_ROOT_USER='pgown'
PSQL_ROOT_PASS='pass'

# POSTGRES SUB-MENU
submenu_psql () {
    HEADING='POSTGRES Controls'
    echo -ne """
$(textred_bg ">> ${HEADING}")
1)$(textgreen 'START')  2)$(textmagenta 'STOP')  3)$(textyellow 'INIT')  4)$(textgreydark 'STATUS')  5)$(textred 'DELETE')  6)$(textgreydark 'SHOW ADMIN PASSWORD')  0)$(textgreydark 'ESC')
"""
    read -p ">> ${HEADING}: " -r
    case ${REPLY} in
        '1') psql_check; ${FUNCNAME[0]};;
        '2') docker_container_stop ${PSQL_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '3') psql_check; ${FUNCNAME[0]};;
        '4') docker_container_status ${PSQL_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '5') docker_container_delete ${PSQL_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '0') submenu_devops;;
        *)
            echo "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

psql_connect () {
    PGHOST=localhost \
    PGPORT=${PSQL_CONTAINER_PORT} \
    PGDATABASE=${PSQL_ROOT_USER}
    PGUSER=${PSQL_ROOT_USER} \
    PGPASSWORD=${PSQL_ROOT_PASS} \
    psql -c "${1}"
}

psql_db_create () {
    echo -e "[CREATE] DATABASE: ${1}"
    if psql_connect "CREATE DATABASE ${1}"
    then
        if psql_connect "GRANT ALL PRIVILEGES ON DATABASE ${1} TO ${PSQL_ROOT_USER}"
        then
            echo -e "[CREATE] SUCCESS."
            return
        fi
    fi
    error1 "${FUNCNAME[0]}"
}

psql_check () {
    check1 "${PSQL_CONTAINER_NAME}"
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
    echo -e "[PSQL] ${PSQL_CONTAINER_NAME} UP and RUNNING"
}

psql_start () {
    echo -e "[START] ${PSQL_CONTAINER_NAME}"
    if docker start ${PSQL_CONTAINER_NAME} > /dev/null
    then
        sleep 5
        echo -e '[START] SUCCESS.'
        return
    fi
    error1 "${FUNCNAME[0]}"
}

psql_create () {
    if psql_server > /dev/null
    then
        sleep 5
        echo -e "[CREATE] SUCCESS: ${PSQL_CONTAINER_NAME}"
        return
    fi
    error1 "${FUNCNAME[0]}"
}

psql_cli () {
    if ! command -v psql > /dev/null
    then
        fail1 '[FAIL] psql CLI not found.'
        return
    fi
    check1 "$(psql --version)"
}

psql_server () {
    docker run -d \
    -p ${PSQL_CONTAINER_PORT}:5432 \
    --name ${PSQL_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -e POSTGRES_USER=${PSQL_ROOT_USER} \
    -e POSTGRES_PASSWORD=${PSQL_ROOT_PASS} \
    postgres:11-buster
}
