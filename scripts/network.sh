#!/bin/bash

docker_network () {
    if ! docker network ls --format '{{ .Name}}' | grep -i $DOCKER_NETWORK_NAME
    then
        echo -e '[NOTICE] Creating network'
        docker network create $DOCKER_NETWORK_NAME
        return
    else
        error1
    fi
}
