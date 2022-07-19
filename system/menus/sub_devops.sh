#!/bin/bash

# JENKINS SUB-MENU
submenu_jenkins () {
    HEADING='JENKINS Controls'
    heading_service ${HEADING}
    textgreydark "(P)SHOW INIT ADMIN PASSWORD"
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') docker_container_start ${JENKINS_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '2') docker_container_stop ${JENKINS_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '3') jenkins_init && submenu_jenkins;;
        [Ss]*) docker_container_status ${JENKINS_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${JENKINS_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Pp]*) if docker exec -it -u root ${JENKINS_CONTAINER_NAME} bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"; then echo ''; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_devops;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# DEBIAN SUB-MENU
submenu_debian () {
    HEADING='DEBIAN Controls'
    heading_run ${HEADING}
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') debian; ${FUNCNAME[0]};;
        '2') docker exec -it ${DEBIAN_CONTAINER_NAME} bash; ${FUNCNAME[0]};;
        '3') debian_init; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${DEBIAN_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${DEBIAN_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_devops;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# POSTGRES SUB-MENU
submenu_psql () {
    HEADING='POSTGRES Controls'
    heading_service ${HEADING}
    echo -en "(L)LIST    (C)CREATE  (R)DROP\n"
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') psql_check; ${FUNCNAME[0]};;
        '2') docker_container_stop ${PSQL_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '3') psql_check; ${FUNCNAME[0]};;
        [Ll]) psql_db_list; ${FUNCNAME[0]};;
        [Cc]) psql_db_create_name; ${FUNCNAME[0]};;
        [Rr]) psql_db_delete; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${PSQL_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${PSQL_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_devops;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}