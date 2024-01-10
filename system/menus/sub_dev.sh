#!/bin/bash

# NODEJS SUB-MENU
nodejs_menu () {
    HEADING='NODEJS'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1) NodeJS $(textgreen 'v.20')
(2) NodeJS $(textgreen 'v.18')
(3) NodeJS $(textgreen 'v.17')
(4) NodeJS $(textgreen 'v.16')
(5) NodeJS $(textgreen 'v.14')
(6) NodeJS $(textgreen 'v.11')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') nodejs "20"; ${FUNCNAME[0]};;
        '2') nodejs "18"; ${FUNCNAME[0]};;
        '3') nodejs "17"; ${FUNCNAME[0]};;
        '4') nodejs "16"; ${FUNCNAME[0]};;
        '5') nodejs "14"; ${FUNCNAME[0]};;
        '6') nodejs "11"; ${FUNCNAME[0]};;
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
(1)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.12-slim')
(2)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.11-slim')
(3)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.10-slim')
(4)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.9-slim')
(5)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.7-slim')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') python "3.12-slim"; ${FUNCNAME[0]};;
        '2') python "3.11-slim"; ${FUNCNAME[0]};;
        '3') python "3.10-slim"; ${FUNCNAME[0]};;
        '4') python "3.9-slim"; ${FUNCNAME[0]};;
        '5') python "3.7-slim"; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_developer;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# PYTHON SUB-MENU
openjdk_menu () {
    HEADING='OpenJDK'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)RUN $(textyellow "OpenJDK") $(textgreen '21')
(2)RUN $(textyellow "OpenJDK") $(textgreen '20')
(3)RUN $(textyellow "OpenJDK") $(textgreen '17')
(4)RUN $(textyellow "OpenJDK") $(textgreen '11')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') openjdk "21"; ${FUNCNAME[0]};;
        '2') openjdk "20"; ${FUNCNAME[0]};;
        '3') openjdk "17"; ${FUNCNAME[0]};;
        '4') openjdk "11"; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_developer;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}
