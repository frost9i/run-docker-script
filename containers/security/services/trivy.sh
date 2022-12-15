#!/bin/bash

TRIVY_CONTAINER_NAME='trivy'
TRIVY_CONTAINER_PORT='4954'
TRIVY_LIST=("${TRIVY_CONTAINER_NAME}" "${TRIVY_CONTAINER_NAME}-srv" "${TRIVY_CONTAINER_NAME}-db")

# https://hub.docker.com/r/aquasec/trivy
# https://hub.docker.com/r/bitnami/trivy (optional)

trivy () {
    docker run -it \
    --rm \
    --entrypoint sh \
    --name "${TRIVY_CONTAINER_NAME}" \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    aquasec/trivy
}

trivy-srv () {
    docker run -it \
    --rm \
    -p 4954:4954 \
    --name "${TRIVY_CONTAINER_NAME}-srv" \
    --network ${DOCKER_NETWORK_NAME} \
    aquasec/trivy \
    server -d --listen 0.0.0.0:${TRIVY_CONTAINER_PORT} --cache-backend redis://${TRIVY_CONTAINER_NAME}-db:6379
}
    # --entrypoint trivy
    # server -d --listen 0.0.0.0:4954 --token token

trivy-redis () {
    docker run \
    -d \
    --rm \
    --name "${TRIVY_CONTAINER_NAME}-db" \
    --network ${DOCKER_NETWORK_NAME} \
    redis:alpine
}
