#!/bin/bash

JIRA_CONTAINER_NAME='jira'
JIRA_CONTAINER_PORT='8800' # 8080

jira_init () {
    psql_check

    psql_db_create ${JIRA_CONTAINER_NAME}

    if script_ask 'MOUNT EXTERNAL FOLDER TO /var/atlassian/application-data/jira ?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/${JIRA_CONTAINER_NAME}:/var/atlassian/application-data/jira"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker_ask_port "${JIRA_CONTAINER_NAME}" "${JIRA_CONTAINER_PORT}"

    if docker_container_create "${JIRA_CONTAINER_NAME}" jira_start
    then
        init1 "${JIRA_CONTAINER_NAME} SUCCESS."
    fi
}

jira_start () {
    psql_check

    docker run -d ${DOCKER_MOUNT_DIR} \
    -p ${CONTAINER_EXPOSED_PORT}:8080 \
    --name ${JIRA_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -e ATL_JDBC_URL="jdbc:postgresql://${PSQL_CONTAINER_NAME}:${PSQL_CONTAINER_PORT}/${JIRA_CONTAINER_NAME}" \
    -e ATL_JDBC_USER=$PSQL_ROOT_USER \
    -e ATL_JDBC_PASSWORD=$PSQL_ROOT_PASS \
    -e ATL_DB_DRIVER='org.postgresql.Driver' \
    -e ATL_DB_TYPE='postgres72' \
    atlassian/jira-software
}

# -v C:/Users/Sergii_Moroz1/docker/jira:/var/atlassian/application-data/jira \
