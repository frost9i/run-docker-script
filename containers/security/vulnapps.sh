#!/bin/bash

JUICESHOP_CONTAINER_NAME='juice-shop'
DVWA_CONTAINER_NAME='dvwa'
VAMPI_CONTAINER_NAME='vampi'

JUICESHOP_PORT='3000' # 3000
DVWA_PORT='3001' # 80
VAMPI_PORT='3002' # 5000

VULNAPPS_LIST=(${JUICESHOP_CONTAINER_NAME} ${DVWA_CONTAINER_NAME} ${VAMPI_CONTAINER_NAME})

juice_shop () {
    docker_ask_port "${JUICESHOP_CONTAINER_NAME}" "${JUICESHOP_PORT}"

    docker run -d \
    --rm \
    --name ${JUICESHOP_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -p ${CONTAINER_EXPOSED_PORT}:3000 \
    bkimminich/juice-shop
}

dvwa () {
    docker_ask_port "${DVWA_CONTAINER_NAME}" "${DVWA_PORT}"

    docker run -d \
    --rm \
    --name ${DVWA_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -p ${CONTAINER_EXPOSED_PORT}:80 \
    vulnerables/web-dvwa
}

vampi () {
    docker_ask_port "${VAMPI_CONTAINER_NAME}" "${VAMPI_PORT}"

    docker run -d \
    --rm \
    --name ${VAMPI_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -p ${CONTAINER_EXPOSED_PORT}:5000 \
    vampi:local
}
