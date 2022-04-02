#!/bin/bash

MOBSF_CONTAINER_NAME='mobsf'
MOBSF_CONTAINER_PORT='8000'
MOBSF_PSQL_DATABASE="${MOBSF_CONTAINER_NAME}"

# MOBSF SUB-MENU
submenu_mobsf () {
    local PS3='>>> MOBSF Controls: '
    local options=('START' 'STOP' 'INITIALIZE' 'STATUS' 'DELETE' 'QUIT')
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            'START')
                docker_container_start "${MOBSF_CONTAINER_NAME}"
                ;;
            'STOP')
                docker_container_stop "${MOBSF_CONTAINER_NAME}"
                ;;
            'INITIALIZE')
                mobsf_init
                ;;
            'STATUS')
                docker_container_status "${MOBSF_CONTAINER_NAME}"
                ;;
            'DELETE')
                docker_container_delete "${MOBSF_CONTAINER_NAME}"
                ;;
            'QUIT')
                PS3='>> SECURITY Tools: '
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

mobsf () {
    docker run -d \
    -p "${CONTAINER_EXPOSED_PORT}":"${MOBSF_CONTAINER_PORT}" \
    --name "${MOBSF_CONTAINER_NAME}" \
    --network "${DOCKER_NETWORK_NAME}" \
    -v "${DOCKER_MY_HOME}"/mobsf:/root/.MobSF \
    -e POSTGRES="True" \
    -e POSTGRES_USER="${PSQL_ROOT_USER}" \
    -e POSTGRES_PASSWORD="${PSQL_ROOT_PASS}" \
    -e POSTGRES_DB="${MOBSF_PSQL_DATABASE}" \
    -e POSTGRES_HOST="${PSQL_CONTAINER_NAME}" \
    opensecurity/mobile-security-framework-mobsf
}

mobsf_init () {
    if ! docker_container_check "${MOBSF_CONTAINER_NAME}"
    then
        psql_check
        psql_db_create "${MOBSF_CONTAINER_NAME}" "${PSQL_ROOT_USER}"
        script_ask_port "${MOBSF_CONTAINER_NAME}" "${MOBSF_CONTAINER_PORT}"
        if mobsf
        then
            ## enable PostgreSQL support
            docker exec -u root "${MOBSF_CONTAINER_NAME}" ./scripts/postgres_support.sh True
            if docker_container_restart "${MOBSF_CONTAINER_NAME}"
            then
                echo -e "[INIT] ${MOBSF_CONTAINER_NAME} SUCCESS."
                return
            fi
            error1
        fi
    fi
}