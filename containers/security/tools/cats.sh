#!/bin/bash

CATS_CONTAINER_NAME='cats'
CATS_DOCKERFILE="Dockerfile-${CATS_CONTAINER_NAME}"

cats_start () {
    if docker_image_check ${CATS_CONTAINER_NAME}
    then
        docker_container_create ${CATS_CONTAINER_NAME} cats
    else
        docker_image_build ${CATS_DOCKERFILE} cats
    fi
}

cats () {
    docker run -it --rm \
    --name $CATS_CONTAINER_NAME \
    --network $DOCKER_NETWORK_NAME \
    cats:local sh
}
