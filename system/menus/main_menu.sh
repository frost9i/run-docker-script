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
    HEADING='DEVOPS Tools'
    echo -ne """
$(textbluelight_bg ">> ${HEADING}")
(1)$(textyellow 'ALPINE') SHELL
(2)$(textmagenta 'DEBIAN') SHELL
(3)$(textred 'JENKINS')
(4)$(textbluelight 'POSTGRES')
(5)RUN $(textred 'REDIS')
(6)$(textblue 'JIRA')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') alpine; ${FUNCNAME[0]};;
        '2') debian; ${FUNCNAME[0]};;
        '3') submenu_jenkins;;
        '4') submenu_psql;;
        '5') redis; ${FUNCNAME[0]};;
        '6') submenu_jira;;
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
        '1') python_menu; ${FUNCNAME[0]};;
        '2') nodejs_menu; ${FUNCNAME[0]};;
        '3') openjdk_menu; ${FUNCNAME[0]};;
        '4') maven; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) mainmenu;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}
