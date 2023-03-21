#!/bin/bash

PSQL_CLIENT='postgres:latest'
PSQL_CLIENT_NAME='psql-client'

postgres_client () {
    docker run -it --rm \
    --name ${PSQL_CLIENT_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    ${PSQL_CLIENT} bash
}