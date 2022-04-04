#!/bin/bash

MOBSF_CONTAINER_NAME='mobsf'
MOBSF_CONTAINER_PORT='8000'
MOBSF_PSQL_DATABASE="${MOBSF_CONTAINER_NAME}"

# MOBSF SUB-MENU
submenu_mobsf () {
    HEADING='MOBSF Controls'
    echo -ne """
$(textbluelight_bg ">> ${HEADING}")
1)$(textgreen 'START')  2)$(textmagenta 'STOP')  3)$(textyellow 'INIT')  4)$(textgreydark 'STATUS')  5)$(textred 'DELETE')  0)$(textgreydark 'ESC')
"""
    read -p ">> ${HEADING}: " -r
    case ${REPLY} in
        '1') docker_container_start ${MOBSF_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '2') docker_container_stop ${MOBSF_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '3') mobsf_init; ${FUNCNAME[0]};;
        '4') docker_container_status ${MOBSF_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '5') docker_container_delete ${MOBSF_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '0') submenu_security;;
        *)
            echo "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
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

        psql_db_create "${MOBSF_CONTAINER_NAME}"

        docker_ask_port "${MOBSF_CONTAINER_NAME}" "${MOBSF_CONTAINER_PORT}"

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