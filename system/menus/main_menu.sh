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
source ./system/menus/sub_security.sh

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

############
## DEVOPS ##
# SUB-MENU #
source ./system/menus/sub_devops.sh

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

#############
## DEVELOP ##
# SUB-MENU ##
source ./system/menus/sub_dev.sh

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
