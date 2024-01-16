#!/bin/bash

# DEVOPS SERVICES SUB-MENU
submenu_devops_services () {
    HEADING='DEVOPS Services'
    echo -ne """
$(textgreen_bg ">> ${HEADING}")
(1)$(textblue 'JENKINS')
(2)$(textcyan 'POSTGRES')
(3)$(textred 'REDIS')
(4)$(textyellow 'SSH SERVER')
(5)$(textgreen 'JIRA')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_jenkins;;
        '2') submenu_psql;;
        '3') redis; ${FUNCNAME[0]};;
        '4') alpine_sshd; ${FUNCNAME[0]};;
        '5') submenu_jira;;
        [Q]) exit;;
        [q]) submenu_devops;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# DEVOPS TOOLS SUB-MENU
submenu_devops_tools () {
    HEADING='DEVOPS Tools'
    echo -ne """
$(textgreen_bg ">> ${HEADING}")
(1)$(textblue 'Postgres client')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') postgres_client; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_devops;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# DEVOPS SHELLS SUB-MENU
submenu_devops_shells () {
    HEADING='DEVOPS Shells'
    echo -ne """
$(textgreen_bg ">> ${HEADING}")
(1)$(textblue 'Debian')
(2)$(textcyan 'Alpine')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') debian; ${FUNCNAME[0]};;
        '2') alpine; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_devops;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

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

# JIRA SUB-MENU
submenu_jira () {
    HEADING='JIRA Controls'
    heading_service ${HEADING}
    echo -en "(L)LOGS\n"
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') docker_container_start ${JIRA_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '2') docker_container_stop ${JIRA_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '3') jira_init && submenu_jira;;
        [Ll]*) docker_container_logs ${JIRA_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${JIRA_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${JIRA_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_devops;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}
