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
        [Ff]*) docker_stop; exit;;
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

############
## DEVOPS ##
# SUB-MENU #
submenu_devops () {
    HEADING='DEVOPS MENU'
    echo -ne """
$(textbluelight_bg ">> ${HEADING}")
(1)$(textyellow 'SERVICES')
(2)$(textblue 'TOOLS')
(3)$(textred 'SHELLS')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') submenu_devops_services;;
        '2') submenu_devops_tools;;
        '3') submenu_devops_shells;;
        [Q]) exit;;
        [q]) mainmenu;;
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
(1)RUN $(textyellow "Python")
(2)RUN $(textgreen 'NodeJS')
(3)RUN $(textmagenta 'JDK')
(4)RUN $(textblue 'MAVEN')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') python_menu;;
        '2') nodejs_menu;;
        '3') openjdk_menu;;
        '4') maven; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) mainmenu;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}
