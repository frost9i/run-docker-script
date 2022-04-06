#!/bin/bash

PSQL_CONTAINER_NAME='postgres'
PSQL_CONTAINER_PORT='5432'
PSQL_ROOT_USER='pgown'
PSQL_ROOT_PASS='pass'

# POSTGRES SUB-MENU
submenu_psql () {
    HEADING='POSTGRES Controls'
    heading_srv ${HEADING}
    echo -en "(L)LIST_db  (C)CREATE_db  (R)DROP_db\n"
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') psql_check; ${FUNCNAME[0]};;
        '2') docker_container_stop ${PSQL_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '3') psql_check; ${FUNCNAME[0]};;
        [Ll]) psql_db_list; ${FUNCNAME[0]};;
        [Cc]) psql_db_create_name; ${FUNCNAME[0]};;
        [Rr]) psql_db_delete; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${PSQL_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${PSQL_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Qq]*) submenu_devops;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

psql_connect () {
    PGHOST=localhost \
    PGPORT=${PSQL_CONTAINER_PORT} \
    PGDATABASE=${PSQL_ROOT_USER}
    PGUSER=${PSQL_ROOT_USER} \
    PGPASSWORD=${PSQL_ROOT_PASS} \
    psql -t -c "${1}"
}

psql_db_create () {
    textgrey_bg "[CREATE] DATABASE: ${1}"
    if psql_connect "CREATE DATABASE ${1}"
    then
        if psql_connect "GRANT ALL PRIVILEGES ON DATABASE ${1} TO ${PSQL_ROOT_USER}"
        then
            textgrey_bg "[CREATE] SUCCESS."
            return
        fi
    fi
    error1 "${FUNCNAME[0]}"
}

psql_db_delete () {
    psql_db_list
    read -p "[INPUT] DROP DATABASE: " -r
    psql_connect "DROP DATABASE IF EXISTS ${REPLY}"
}

psql_db_create_name () {
    read -p "[INPUT] CREATE DATABASE: " -r
    psql_db_create "${REPLY}"
}

psql_db_list () {
    textgrey_bg "DATABASE LIST:"
    psql_connect "SELECT datname FROM pg_database WHERE datname <> ALL ('{template0,template1,postgres,pgown}')"
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
    textgreen_bg "[PSQL] ${PSQL_CONTAINER_NAME} UP and RUNNING"
}

psql_start () {
    textgrey_bg "[START] ${PSQL_CONTAINER_NAME}"
    if docker start ${PSQL_CONTAINER_NAME} > /dev/null
    then
        sleep 5
        textgreen_bg '[START] SUCCESS.'
        return
    fi
    error1 "${FUNCNAME[0]}"
}

psql_create () {
    if psql_server > /dev/null
    then
        sleep 5
        textgreen_bg "[CREATE] SUCCESS: ${PSQL_CONTAINER_NAME}"
        return
    fi
    error1 "${FUNCNAME[0]}"
}

psql_cli_check () {
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
