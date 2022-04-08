#!/bin/bash

PYTHON_CONTAINER_NAME='python'

DEV_LIST=(${PYTHON_CONTAINER_NAME})

python () {
    docker run -it \
    --rm \
    --name ${PYTHON_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    python:slim bash
}
