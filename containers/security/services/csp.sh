#!/bin/bash

CSP_CONTAINER_NAME='csp'
CSP_CONTAINER_PORT='9180'

# Main config:
CSP_PARAM_PORT='9180'
CSP_PARAM_METRICS='no'
CSP_PARAM_PATH='///csp'
CSP_PARAM_HEALZ='///about'
CSP_PARAM_LOGLEVEL='DEBUG' # CRITICAL:50, ERROR:40, WARNING:30, INFO:20, DEBUG:10, NOTSET:0
# https://docs.python.org/3/library/logging.html#levels

# Other settings:
# | **Variable**             | **Default** | **Description**                                                        |
# |:-------------------------|:-----------:|:-----------------------------------------------------------------------|
# | `MAX_CONTENT_LENGTH`     | `32768`     | The maximum content length (in bytes) of the HTTP POST content         |
# | `ENABLE_HEALTHZ_VERSION` | `no`        | Set this to `yes` to show the version on the `HEALTHZ_PATH` endpoint   |
# | `ENABLE_METRICS`         | `no`        | Set this to `yes` to enable the Prometheus metrics                     |
# | `CSP_PATH`               | `/csp`      | The path used for the CSP reporting                                    |
# | `HEALTHZ_PATH`           | `/healthz`  | The path used for the healthcheck                                      |
# | `METRICS_PATH`           | `/metrics`  | The path used for the the Prometheus metrics                           |
# | `LOGLEVEL`               | `INFO`      | [Logging Level](https://docs.python.org/3/library/logging.html#levels) |
# | `GELF_HOST`              | -           | If set, GELF UDP logging to this host will be enabled                  |
# | `GELF_PORT`              | `12201`     | Ignored, if `GELF_HOST` is unset. The UDP port for GELF logging        |
# | `PORT`                   | `9180`      | The port to bind to                                                    |
# | `ADDRESS`                | `*`         | The IP address to bind to                                              |

csp_processor () {
    docker_ask_port "${CSP_CONTAINER_NAME}" "${CSP_CONTAINER_PORT}"

    docker run \
    -d --rm \
    -p $CSP_CONTAINER_PORT:$CSP_PARAM_PORT \
    --name $CSP_CONTAINER_NAME --network $DOCKER_NETWORK_NAME \
    -e PORT=$CSP_PARAM_PORT \
    -e ENABLE_METRICS=$CSP_PARAM_METRICS \
    -e LOGLEVEL=$CSP_PARAM_LOGLEVEL \
    -e CSP_PATH=$CSP_PARAM_PATH \
    -e HEALTHZ_PATH=$CSP_PARAM_HEALZ \
    ixdotai/csp \
    && echo_port "$CSP_CONTAINER_PORT"
}
