#!/bin/bash

# SECURITY SERVICES SUB-MENU
submenu_security_services () {
    HEADING='SECURITY Services'
    echo -ne """
$(textgreen_bg ">> ${HEADING}")
(1)$(textblue 'DEFECT-DOJO')
(2)$(textcyan 'DEPENDENCY-TRACK')
(3)$(textyellow 'MobSF')
(4)$(textgreen 'Mozilla-Observatory')
(5)$(textmagenta 'CSP-Processor')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_dd;;
        '2') submenu_dt;;
        '3') submenu_mobsf;;
        '4') submenu_obs;;
        '5') submenu_csp;;
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
    HEADING='Mobile-Security-Framework Controls'
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
    echo -ne "$(textblue '(B)BUILD IMAGE\n')"
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

# CSP PROCESSOR SUB-MENU
submenu_csp () {
    HEADING='CSP-PROCESSOR Controls'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)$(textgreen "RUN")
(2)$(textred "STOP")
(3)$(textyellow "LOGS")
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') docker_container_create ${CSP_CONTAINER_NAME} csp_processor; ${FUNCNAME[0]};;
        '2') docker_container_stop ${CSP_CONTAINER_NAME}; ${FUNCNAME[0]};;
        '3') docker logs -f ${CSP_CONTAINER_NAME} && ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${CSP_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${CSP_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_services;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

#############################
## SECURITY TOOLS SUB-MENU ##
submenu_security_tools () {
    HEADING='SECURITY Tools'
    echo -ne """
$(textred_bg ">> ${HEADING}")
(1)RUN $(textblue 'ZAP')
(2)RUN $(textblue 'SEMGREP')
(3)RUN $(textyellow 'CATS')
(4)RUN $(textyellow 'TruffleHog')
(5)RUN $(textgreen 'Trivy')
(6)RUN $(textgreen 'Dependency Check')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') zap; ${FUNCNAME[0]};;
        '2') semgrep; ${FUNCNAME[0]};;
        '3') cats_start ${FUNCNAME[0]};;
        '4') trufflehog; ${FUNCNAME[0]};;
        '5') trivy; ${FUNCNAME[0]};;
        '6') dcheck; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security;;
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
        '3') if docker_image_check ${VAMPI_CONTAINER_NAME}; then docker_container_create ${VAMPI_CONTAINER_NAME} ${VAMPI_CONTAINER_NAME}; else docker_image_build 'Dockerfile-vampi' ${VAMPI_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Ss]*) docker_container_stop ${VULNAPPS_LIST[@]}; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}
