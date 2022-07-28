#!/bin/bash

TRIVY_CONTAINER_NAME='trivy'
DCHECK_CONTAINER_NAME='dcheck'

DEV_LIST=(${TRIVY_CONTAINER_NAME}, ${DCHECK_CONTAINER_NAME})

trivy () {
    docker run -it \
    --rm \
    --entrypoint sh \
    --name "${TRIVY_CONTAINER_NAME}" \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    aquasec/trivy
}
    # bitnami/trivy bash

dcheck () {
    docker run -it \
    --rm \
    --entrypoint sh \
    --name ${DCHECK_CONTAINER_NAME} \
    --network ${DOCKER_NETWORK_NAME} \
    -v "${DOCKER_MY_HOME}/git:/git" \
    owasp/dependency-check
}
