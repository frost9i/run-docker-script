#!/bin/bash

CATS_CONTAINER_NAME='cats'

cats () {
    docker run -it --rm \
    --name $CATS_CONTAINER_NAME \
    --network $DOCKER_NETWORK_NAME \
    cats:local sh
}


