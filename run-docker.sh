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

# DEVOPS Services
source ./services/jenkins.sh
source ./services/postgres.sh
source ./services/debian.sh

# DEVELOPER Services
# todo

# SECURITY SUB-MENU
submenu_security () {
    HEADING='SECURITY Tools'
    echo -ne """
$(textgreen ">> ${HEADING}")
1) $(textbluelight 'DEFECT-DOJO')
2) $(textcyan 'DEPENDENCY-TRACK')
3) $(textbluelight 'MOBSF')
4) $(textyellow 'ZAP')
5) $(textred 'PENTEST >')
0) $(textgreydark 'ESC')
"""
    read -p ">> ${HEADING}: " -r
    case ${REPLY} in
        '1') submenu_dd;;
        '2') submenu_dt;;
        '3') submenu_mobsf;;
        '4') submenu_zap;;
        '5') submenu_pentest;;
        '0') mainmenu;;
        *) echo "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# DEVOPS SUB-MENU
submenu_devops () {
    HEADING='DEVOPS Tools'
    echo -ne """
$(textbluelight_bg ">> ${HEADING}")
1) $(textred 'JENKINS')
2) $(textbluelight 'POSTGRES')
3) $(textmagenta 'DEBIAN')
0) $(textgreydark 'ESC')
"""
    read -p ">> ${HEADING}: " -r
    case ${REPLY} in
        '1') submenu_jenkins;;
        '2') submenu_psql;;
        '3') submenu_debian;;
        '0') mainmenu;;
        *) echo "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# DEVELOPER SUB-MENU
submenu_developer () {
    HEADING='DEVELOPER Tools'
    echo -ne """
$(textgrey_bg ">> ${HEADING}")
1) $(textgrey 'JRE')
2) $(textgrey 'NPM')
0) $(textgreydark 'ESC')
"""
    read -p ">> ${HEADING}: " -r
    case ${REPLY} in
        '1') submenu_todo; ${FUNCNAME[0]};;
        '2') submenu_todo; ${FUNCNAME[0]};;
        '0') mainmenu;;
        *) echo "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# MAIN MENU
mainmenu () {
    HEADING='MAIN MENU'
    echo -en """
$(textblue_bg "> ${HEADING}")
1) $(textgreen 'SECURITY')
2) $(textyellow 'DEVOPS')
3) $(textgrey 'DEVELOPER')
4) $(textred 'FULL STOP')
0) $(textgreydark 'QUIT')
"""
    read -p "> ${HEADING}: " -r
    case ${REPLY} in
        '1') submenu_security;;
        '2') submenu_devops;;
        '3') submenu_developer;;
        '4') docker_stop; ${FUNCNAME[0]};;
        '0') exit;;
        *)
            echo "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# START HERE ->
date
docker_check
docker_home_check
docker_network
psql_cli

mainmenu
