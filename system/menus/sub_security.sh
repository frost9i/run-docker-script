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
(6)$(textgreen 'Trivy')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_dd;;
        '2') submenu_dt;;
        '3') submenu_mobsf;;
        '4') submenu_obs;;
        '5') submenu_csp;;
        '6') submenu_trivy;;
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
    echo -en "SHOW:      (L)Logs-api(K)Logs-fe\n"
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') psql_check; docker_container_start ${DT_LIST[@]}; ${FUNCNAME[0]};;
        '2') docker_container_stop ${DT_LIST[@]}; ${FUNCNAME[0]};;
        '3') dt_init; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${DT_LIST[@]}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${DT_LIST[@]}; fi; ${FUNCNAME[0]};;
        [Ll]*) docker logs -f ${DT_CONTAINER_API}; ${FUNCNAME[0]};;
        [Kk]*) docker logs -f ${DT_CONTAINER_FE}; ${FUNCNAME[0]};;
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
(L)$(textyellow "LOGS")
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') docker_container_create ${CSP_CONTAINER_NAME} csp_processor; ${FUNCNAME[0]};;
        '2') docker_container_stop ${CSP_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Ll]) docker logs -f ${CSP_CONTAINER_NAME} && ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${CSP_CONTAINER_NAME}; ${FUNCNAME[0]};;
        [Dd]*) if script_ask "Confirm"; then docker_container_delete ${CSP_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_services;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# TRIVY SUB-MENU
submenu_trivy () {
    HEADING='TRIVY Controls'
    echo -ne """
$(textgreen_bg ">> ${HEADING}")
(1)$(textgreen "TRIVY") SHELL
(2)$(textyellow "TRIVY") SERVER
(3)$(textred "TRIVY") DB
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') trivy; ${FUNCNAME[0]};;
        '2') trivy-srv; ${FUNCNAME[0]};;
        '3') trivy-redis; ${FUNCNAME[0]};;
        [Ss]*) docker_container_status ${TRIVY_LIST[@]}; ${FUNCNAME[0]};;
        # [Dd]*) if script_ask "Confirm"; then docker_container_delete ${OBS_LIST[@]}; fi; ${FUNCNAME[0]};;
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
(1)RUN $(textblue 'SAST')
(2)RUN $(textyellow 'SCA')
(3)RUN $(textmagenta 'DAST')
(4)RUN $(textcyan 'SECRETS')
(5)RUN $(textbluelight 'FUZZ')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_security_tools_sast;;
        '2') submenu_security_tools_sca;;
        '3') submenu_security_tools_dast;;
        '4') submenu_security_tools_secrets;;
        '5') submenu_security_tools_fuzz;;
        [Q]) exit;;
        [q]) submenu_security;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

submenu_security_tools_sast () {
    HEADING='SECURITY SAST Tools'
    echo -ne """
$(textred_bg ">> ${HEADING}")
(1)RUN $(textgreen 'Semgrep')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') semgrep; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_tools;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

submenu_security_tools_sca () {
    HEADING='SECURITY SCA Tools'
    echo -ne """
$(textred_bg ">> ${HEADING}")
(1)RUN $(textgreen 'Clair')
(2)RUN $(textred 'Syft')
(3)RUN $(textyellow 'Trivy')
(4)RUN $(textblue 'Dependency Check')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') clair; ${FUNCNAME[0]};;
        '2') syft; ${FUNCNAME[0]};;
        '3') trivy; ${FUNCNAME[0]};;
        '4') dcheck; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_tools;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

submenu_security_tools_dast () {
    HEADING='SECURITY DAST Tools'
    echo -ne """
$(textred_bg ">> ${HEADING}")
(1)RUN $(textblue 'ZAP Scan')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') zap; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_tools;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

submenu_security_tools_secrets () {
    HEADING='SECURITY Secret detection Tools'
    echo -ne """
$(textred_bg ">> ${HEADING}")
(1)RUN $(textblue 'Detect-secrets')
(2)RUN $(textgreen 'Gitleaks')
(3)RUN $(textyellow 'Trufflehog')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') dsecrets; ${FUNCNAME[0]};;
        '2') gitleaks; ${FUNCNAME[0]};;
        '3') trufflehog; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security_tools;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

submenu_security_tools_fuzz () {
    HEADING='SECURITY etc'
    echo -ne """
$(textred_bg ">> ${HEADING}")
(1)RUN $(textblue 'Cats')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') cats_start ${FUNCNAME[0]};;
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
        '3') if docker_image_check ${VAMPI_CONTAINER_NAME}; then docker_container_create ${VAMPI_CONTAINER_NAME} ${VAMPI_CONTAINER_NAME}; else docker_image_build 'Dockerfile-vampi' ${VAMPI_CONTAINER_NAME}; fi; ${FUNCNAME[0]};;
        [Ss]*) docker_container_stop ${VULNAPPS_LIST[@]}; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_security;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}
