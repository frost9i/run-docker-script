#!/bin/bash

###############
## MAIN MENU ##
mainmenu () {
    HEADING='MAIN MENU'
    echo -ne """
$(textblue_bg "> ${HEADING}")
(1)$(textgreen 'SECURITY')
(2)$(textyellow 'DEVOPS')
(3)$(textcyan 'DEVTOOLS')
(F)$(textred 'FULLSTOP')
(Q)$(textgrey 'QUIT')
"""
    read -p $"> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_security;;
        '2') submenu_devops;;
        '3') submenu_developer;;
        [Ff]*) if script_ask "Confirm"; then docker_stop; exit; fi; ${FUNCNAME[0]};;
        [Qq]*) exit;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

##############
## SECURITY ##
# SUB-MENU ###
submenu_security () {
    HEADING='SECURITY Tools'
    echo -ne """
$(textgreen_bg ">> ${HEADING}")
(1)$(textcyan 'SERVICES >')
(2)$(textgreen 'TOOLS >')
(3)$(textred 'VULNERABLE APPS >')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_security_services;;
        '2') submenu_security_tools;;
        '3') submenu_vulnapps;;
        [Q]) exit;;
        [q]) mainmenu;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# SECURITY SERVICES SUB-MENU
submenu_security_services () {
    HEADING='SECURITY Services'
    echo -ne """
$(textgreen_bg ">> ${HEADING}")
(1)$(textbluelight 'DEFECT-DOJO')
(2)$(textgreen 'DEPENDENCY-TRACK')
(3)$(textcyan 'Mobile-Security-Framework')
(4)$(textred 'Mozilla-Observatory')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_dd;;
        '2') submenu_dt;;
        '3') submenu_mobsf;;
        '4') submenu_obs;;
        [Q]) exit;;
        [q]) submenu_security;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# DEFECT-DOJO SUB-MENU
submenu_dd () {
    HEADING='DEFECT-DOJO Controls'
    heading_service ${HEADING}
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') psql_check; docker_container_start ${DD_LIST[@]}; ${FUNCNAME[0]};;
        '2') docker_container_stop ${DD_LIST[@]}; ${FUNCNAME[0]};;
        '3') dd_init; ${FUNCNAME[0]};;
        '4') submenu_todo;; # delete database
        [Ss]*) docker_container_status ${DD_LIST[@]}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${DD_LIST[@]}; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_services;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# DEPENDENCY-TRACK SUB-MENU
submenu_dt () {
    HEADING='DEPENDENCY-TRACK Controls'
    heading_service ${HEADING}
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') psql_check; docker_container_start ${DT_LIST[@]}; ${FUNCNAME[0]};;
        '2') docker_container_stop ${DT_LIST[@]}; ${FUNCNAME[0]};;
        '3') dt_init; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${DT_LIST[@]}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${DT_LIST[@]}; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_services;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# MOBSF SUB-MENU
submenu_mobsf () {
    HEADING='MOBSF Controls'
    heading_service ${HEADING}
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') docker_container_start ${MOBSF_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '2') docker_container_stop ${MOBSF_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '3') mobsf_init; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${MOBSF_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then  docker_container_delete ${MOBSF_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_services;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# MOZILLA OBSERVATORY SUB-MENU
submenu_obs () {
    HEADING='MOZILLA-OBSERVATORY Controls'
    heading_service ${HEADING}
    echo -ne "(B)BUILD IMAGE\n"
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') psql_check; docker_container_start ${OBS_LIST[@]}; ${FUNCNAME[0]};;
        '2') docker_container_stop ${OBS_LIST[@]}; ${FUNCNAME[0]};;
        '3') obs_init; ${FUNCNAME[0]};;
        [Bb]*) docker_image_build ${OBS_DOCKERFILE} ${OBS_SERVICE_NAME}; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${OBS_LIST[@]}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${OBS_LIST[@]}; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_services;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# SECURITY TOOLS SUB-MENU
submenu_security_tools () {
    HEADING='SECURITY Tools'
    echo -ne """
$(textred_bg ">> ${HEADING}")
(1)RUN $(textblue 'SEMGREP')
(2)RUN $(textcyan 'ZAP')
(3)RUN $(textyellow 'Trivy')
(4)RUN $(textgreen 'Dependency Check')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') docker_container_create ${SEMGREP_CONTAINER_NAME} semgrep; ${FUNCNAME[0]};;
        '2') docker_container_create ${ZAP_CONTAINER_NAME} zap; ${FUNCNAME[0]};;
        '3') trivy; ${FUNCNAME[0]};;
        '4') dcheck; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# ZAP SUB-MENU
submenu_zap () {
    HEADING='ZAP Controls'
    heading_run ${HEADING}
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') zap; ${FUNCNAME[0]};;
        '2') docker exec -it "${ZAP_CONTAINER_NAME}" bash; ${FUNCNAME[0]};;
        '3') zap_init; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${ZAP_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then  docker_container_delete ${ZAP_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_tools;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# VULNAPPS SUB-MENU
submenu_vulnapps () {
    HEADING='VULNERABLE Apps'
    echo -ne """
$(textred_bg ">> ${HEADING}")
(1)RUN $(textyellow 'JUICE-SHOP')
(2)RUN $(textcyan 'DVWA')
(3)RUN $(textmagenta 'VAMPI')
(S)$(textred 'STOP ALL')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') docker_container_create ${JUICESHOP_CONTAINER_NAME} juice_shop; ${FUNCNAME[0]};;
        '2') docker_container_create ${DVWA_CONTAINER_NAME} dvwa; ${FUNCNAME[0]};;
        '3') if docker_image_check 'vampi'; then docker_container_create ${VAMPI_CONTAINER_NAME} vampi; else docker_image_build 'Dockerfile-vampi' 'vampi'; fi; ${FUNCNAME[0]};;
        [Ss]*) docker_container_stop ${VULNAPPS_LIST[@]}; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

############
## DEVOPS ##
# SUB-MENU #
submenu_devops () {
    HEADING='DEVOPS Tools'
    echo -ne """
$(textbluelight_bg ">> ${HEADING}")
(1)$(textred 'JENKINS')
(2)$(textbluelight 'POSTGRES')
(3)$(textmagenta 'DEBIAN')
(4)RUN $(textcyan 'REDIS')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_jenkins;;
        '2') submenu_psql;;
        '3') submenu_debian;;
        '4') redis; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) mainmenu;;
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

#############
## DEVELOP ##
# SUB-MENU ##
submenu_developer () {
    HEADING='DEV TOOLS'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)RUN $(textyellow 'PYTHON')
(2)RUN $(textgreen 'NODE.JS')
(3)RUN $(textblue 'MAVEN')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') python_menu; ${FUNCNAME[0]};;
        '2') nodejs_menu; ${FUNCNAME[0]};;
        '3') maven; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) mainmenu;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# NODEJS SUB-MENU
nodejs_menu () {
    HEADING='NODEJS'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)RUN $(textgreen "NODEJS") $(textyellow 'v.11')
(2)RUN $(textgreen "NODEJS") $(textyellow 'v.17')
(3)RUN $(textgreen "NODEJS") $(textyellow 'v.18')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') nodejs "11"; ${FUNCNAME[0]};;
        '2') nodejs "17"; ${FUNCNAME[0]};;
        '3') nodejs "18"; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_developer;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# PYTHON SUB-MENU
python_menu () {
    HEADING='PYTHON'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)RUN $(textyellow "PYTHON") $(textgreen '3.7')
(2)RUN $(textyellow "PYTHON") $(textgreen '3.9')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') python "3.7"; ${FUNCNAME[0]};;
        '2') python "3.9"; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_developer;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}
