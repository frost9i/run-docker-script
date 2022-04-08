#!/bin/bash

# VARIABLES
# DOCKER_MY_HOME="C:/Users/your_name/docker" is set as environmental variable
DOCKER_NETWORK_NAME='docker-net'

# System
source ./system/docker.sh
source ./system/echo.sh
source ./system/colors.sh

# SECURITY Services
source ./services/ddojo.sh
source ./services/dtrack.sh
source ./services/mobsf.sh
source ./services/zap.sh
source ./services/pentest.sh
source ./services/sast.sh

# DEVOPS Services
source ./services/jenkins.sh
source ./services/postgres.sh
source ./services/debian.sh

# DEVTOOLS
source ./services/dev.sh

# DEVELOPER Services
# todo

# SECURITY SUB-MENU
submenu_security () {
    HEADING='SECURITY Tools'
    echo -ne """
$(textgreen_bg ">> ${HEADING}")
(1)$(textbluelight 'DEFECT-DOJO')
(2)$(textcyan 'DEPENDENCY-TRACK')
(3)$(textbluelight 'MOBSF')
(4)$(textyellow 'ZAP')
(5)$(textred 'PENTEST >')
(6)$(textgreen 'SAST >')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_dd;;
        '2') submenu_dt;;
        '3') submenu_mobsf;;
        '4') submenu_zap;;
        '5') submenu_pentest;;
        '6') submenu_sast;;
        [Q]) exit;;
        [q]) mainmenu;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# DEVOPS SUB-MENU
submenu_devops () {
    HEADING='DEVOPS Tools'
    echo -ne """
$(textbluelight_bg ">> ${HEADING}")
(1)$(textred 'JENKINS')
(2)$(textbluelight 'POSTGRES')
(3)$(textmagenta 'DEBIAN')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_jenkins;;
        '2') submenu_psql;;
        '3') submenu_debian;;
        [Q]) exit;;
        [q]) mainmenu;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# DEVELOPER SUB-MENU
submenu_developer () {
    HEADING='DEV TOOLS'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)$(textyellow 'RUN PYTHON')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') python; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) mainmenu;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# MAIN MENU
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

# START HERE ->
date
docker_check
docker_home_check
docker_network
psql_cli_check

mainmenu
