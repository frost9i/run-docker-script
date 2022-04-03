#!/bin/bash

DD_SERVICE_NAME='defectdojo'
DD_PSQL_DATABASE="${DD_SERVICE_NAME}"

DD_UWSGI_PORT='8080'
DD_CONTAINER_UWSGI="${DD_SERVICE_NAME}"
DD_CONTAINER_NGINX="${DD_SERVICE_NAME}-nginx"
DD_CONTAINER_BEAT="${DD_SERVICE_NAME}-beat"
DD_CONTAINER_WORKER="${DD_SERVICE_NAME}-worker"

DD_SECRET_KEY_SET='hhZCp@D28z!n@NED*yB!ROMt+WzsY*iq'

DD_CONTAINER_RABBITMQ='rabbitmq'
DD_RABBITMQ_USER="${DD_SERVICE_NAME}"
DD_RABBITMQ_PASS="${DD_SERVICE_NAME}"

DD_LIST=("${DD_CONTAINER_UWSGI}"
    "${DD_CONTAINER_NGINX}"
    "${DD_CONTAINER_BEAT}"
    "${DD_CONTAINER_WORKER}"
    "${DD_CONTAINER_RABBITMQ}")

# DEFECT-DOJO SUB-MENU
submenu_dd () {
    local PS3='>> DEFECT-DOJO Controls: '
    local options=('START' 'STOP' 'INIT' 'STATUS' 'DELETE' 'QUIT')
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            'START')
                docker_container_start ${DD_LIST}
                ;;
            'STOP')
                docker_container_stop ${DD_LIST}
                ;;
            'INIT')
                dd_init
                ;;
            'STATUS')
                docker_container_status ${DD_LIST}
                ;;
            'DELETE')
                docker_container_delete ${DD_LIST}
                ;;
            'QUIT')
                PS3='>> SECURITY Tools: '
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

dd_init () {
    echo -e "[INIT] DEFECTDOJO"

    psql_check

    psql_db_create "${DD_PSQL_DATABASE}"

    if script_ask 'MOUNT EXTERNAL dojo-app FOLDER?'
    then
        DOCKER_MOUNT_DIR="-v ${DOCKER_MY_HOME}/ddojo-app:/app"
    else
        DOCKER_MOUNT_DIR=''
    fi

    docker_ask_port "${DD_CONTAINER_UWSGI}" "${DD_UWSGI_PORT}"

    if docker_container_create "${DD_CONTAINER_UWSGI}" dd_uwsgi
    then
        if docker exec -it "${DD_CONTAINER_UWSGI}" ./../entrypoint-initializer.sh
        then
            echo -e "[INIT] ${DD_CONTAINER_UWSGI} SUCCESS."
        fi
    fi

    if docker_container_create "${DD_CONTAINER_NGINX}" dd_nginx
    then
        echo "[INIT] ${DD_CONTAINER_NGINX} SUCCESS."
    fi

    if docker_container_create "${DD_CONTAINER_BEAT}" dd_beat
    then
        echo "[INIT] ${DD_CONTAINER_BEAT} SUCCESS."
    fi

    if docker_container_create "${DD_CONTAINER_WORKER}" dd_worker
    then
        echo "[INIT] ${DD_CONTAINER_WORKER} SUCCESS."
    fi

    if docker_container_create "${DD_CONTAINER_RABBITMQ}" dd_rabbitmq
    then
        echo "[INIT] ${DD_CONTAINER_RABBITMQ} SUCCESS."
    fi
}

# Enable RabbitMQ web management plugin
# docker exec -it ${DD_CONTAINER_RABBITMQ} rabbitmq-plugins enable rabbitmq_management
# -p 5672:5672 -p 15672:15672
dd_rabbitmq () {
    docker run -d \
    --name ${DD_CONTAINER_RABBITMQ} \
    --network ${DOCKER_NETWORK_NAME} \
    -e RABBITMQ_DEFAULT_USER=${DD_RABBITMQ_USER} \
    -e RABBITMQ_DEFAULT_PASS=${DD_RABBITMQ_PASS} \
    rabbitmq:latest
}

# -v ${DOCKER_MY_HOME}/ddojo-app:/app \
dd_uwsgi () {
    docker run -d ${DOCKER_MOUNT_DIR} \
    -p ${CONTAINER_EXPOSED_PORT}:${DD_UWSGI_PORT} \
    --name ${DD_CONTAINER_UWSGI} \
    --network ${DOCKER_NETWORK_NAME} \
    --entrypoint='//entrypoint-uwsgi.sh' \
    -e DD_ALLOWED_HOSTS='*' \
    -e DD_CELERY_BROKER_HOST=${DD_CONTAINER_RABBITMQ} \
    -e DD_CELERY_BROKER_PORT='5672' \
    -e DD_CELERY_BROKER_SCHEME='amqp' \
    -e DD_CELERY_BROKER_USER=${DD_RABBITMQ_USER} \
    -e DD_CELERY_BROKER_PASSWORD=${DD_RABBITMQ_PASS} \
    -e DD_CELERY_BROKER_PATH='//' \
    -e DD_CELERY_BEAT_SCHEDULE_FILENAME='/run/celery-beat-schedule' \
    -e DD_DATABASE_ENGINE='django.db.backends.postgresql' \
    -e DD_DATABASE_URL="postgresql://${PSQL_ROOT_USER}:${PSQL_ROOT_PASS}@${PSQL_CONTAINER_NAME}:5432/${DD_PSQL_DATABASE}" \
    -e DD_DATABASE_HOST=${PSQL_CONTAINER_NAME} \
    -e DD_DATABASE_PORT=${PSQL_CONTAINER_PORT} \
    -e DD_DATABASE_NAME=${DD_PSQL_DATABASE} \
    -e DD_DATABASE_USER=${PSQL_ROOT_USER} \
    -e DD_DATABASE_PASSWORD=${PSQL_ROOT_PASS} \
    -e DD_UWSGI_ENDPOINT='0.0.0.0:3031' \
    -e DD_ADMIN_USER='admin' \
    -e DD_ADMIN_PASSWORD='pass' \
    -e DD_ADMIN_MAIL='admin@defectdojo.local' \
    -e DD_ADMIN_FIRST_NAME='super' \
    -e DD_ADMIN_LAST_NAME='user' \
    -e DD_SECRET_KEY=${DD_SECRET_KEY_SET} \
    defectdojo/defectdojo-django
}

# -e DD_SITE_URL='https://somewhere.com' \
# -e DD_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_ENABLED="True" \
# -e DD_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_KEY='2b253d0d-3f58-4b57-bfa6-b0991f2ac166' \
# -e DD_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_SECRET='j7m7Q~paDLiKl~u1AaLJow-h2s0.xWhC4vPbf' \
# -e DD_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_TENANT_ID='e0c5f441-1d00-4220-8b89-2b8fd152f219' \

dd_nginx () {
    docker run -d \
    -p 9000:8080 \
    --name ${DD_CONTAINER_NGINX} \
    --network ${DOCKER_NETWORK_NAME} \
    -e DD_UWSGI_HOST=${DD_CONTAINER_UWSGI} \
    -e DD_UWSGI_PORT='3031' \
    -e DD_UWSGI_PASS="${DD_CONTAINER_NGINX}:3031" \
    defectdojo/defectdojo-nginx
}

dd_worker () {
    docker run -d \
    --name ${DD_CONTAINER_WORKER} \
    --network ${DOCKER_NETWORK_NAME} \
    --entrypoint='//entrypoint-celery-worker.sh' \
    -e DD_ALLOWED_HOSTS='*' \
    -e DD_CELERY_BROKER_HOST=${DD_CONTAINER_RABBITMQ} \
    -e DD_CELERY_BROKER_PORT='5672' \
    -e DD_CELERY_BROKER_SCHEME='amqp' \
    -e DD_CELERY_BROKER_USER=${DD_RABBITMQ_USER} \
    -e DD_CELERY_BROKER_PASSWORD=${DD_RABBITMQ_PASS} \
    -e DD_CELERY_BROKER_PATH='//' \
    -e DD_CELERY_BEAT_SCHEDULE_FILENAME='/run/celery-beat-schedule' \
    -e DD_DATABASE_ENGINE='django.db.backends.postgresql' \
    -e DD_DATABASE_URL="postgresql://${PSQL_ROOT_USER}:${PSQL_ROOT_PASS}@${PSQL_CONTAINER_NAME}:${PSQL_CONTAINER_PORT}/${DD_PSQL_DATABASE}" \
    -e DD_DATABASE_HOST=${PSQL_CONTAINER_NAME} \
    -e DD_DATABASE_PORT=${PSQL_CONTAINER_PORT} \
    -e DD_DATABASE_NAME=${DD_PSQL_DATABASE} \
    -e DD_DATABASE_USER=${PSQL_ROOT_USER} \
    -e DD_DATABASE_PASSWORD=${PSQL_ROOT_PASS} \
    -e DD_UWSGI_ENDPOINT='0.0.0.0:3031' \
    -e DD_SECRET_KEY=${DD_SECRET_KEY} \
    defectdojo/defectdojo-django
}

dd_beat () {
    docker run -d \
    --name ${DD_CONTAINER_BEAT} \
    --network ${DOCKER_NETWORK_NAME} \
    --entrypoint='//entrypoint-celery-beat.sh' \
    -e DD_ALLOWED_HOSTS='*' \
    -e DD_CELERY_BROKER_HOST=${DD_CONTAINER_RABBITMQ} \
    -e DD_CELERY_BROKER_PORT='5672' \
    -e DD_CELERY_BROKER_SCHEME='amqp' \
    -e DD_CELERY_BROKER_USER=${DD_RABBITMQ_USER} \
    -e DD_CELERY_BROKER_PASSWORD=${DD_RABBITMQ_PASS} \
    -e DD_CELERY_BROKER_PATH='//' \
    -e DD_CELERY_BEAT_SCHEDULE_FILENAME='/run/celery-beat-schedule' \
    -e DD_DATABASE_ENGINE='django.db.backends.postgresql' \
    -e DD_DATABASE_URL="postgresql://${PSQL_ROOT_USER}:${PSQL_ROOT_PASS}@${PSQL_CONTAINER_NAME}:${PSQL_CONTAINER_PORT}/${DD_PSQL_DATABASE}" \
    -e DD_DATABASE_HOST=${PSQL_CONTAINER_NAME} \
    -e DD_DATABASE_PORT=${PSQL_CONTAINER_PORT} \
    -e DD_DATABASE_NAME=${DD_PSQL_DATABASE} \
    -e DD_DATABASE_USER=${PSQL_ROOT_USER} \
    -e DD_DATABASE_PASSWORD=${PSQL_ROOT_PASS} \
    -e DD_UWSGI_ENDPOINT='0.0.0.0:3031' \
    -e DD_SECRET_KEY=${DD_SECRET_KEY} \
    defectdojo/defectdojo-django
}
