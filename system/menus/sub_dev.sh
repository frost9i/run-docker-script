#!/bin/bash

# NODEJS SUB-MENU
nodejs_menu () {
    HEADING='NODEJS'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1) NodeJS $(textgreen 'v.18')
(2) NodeJS $(textgreen 'v.17')
(3) NodeJS $(textgreen 'v.16')
(4) NodeJS $(textgreen 'v.14')
(5) NodeJS $(textgreen 'v.11')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') nodejs "18"; ${FUNCNAME[0]};;
        '2') nodejs "17"; ${FUNCNAME[0]};;
        '3') nodejs "16"; ${FUNCNAME[0]};;
        '4') nodejs "14"; ${FUNCNAME[0]};;
        '5') nodejs "11"; ${FUNCNAME[0]};;
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
(1)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.10-slim')
(2)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.9-slim')
(3)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.7-slim')
(4)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.10')
(5)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.9')
(6)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.7')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') python "3.10-slim"; ${FUNCNAME[0]};;
        '2') python "3.9-slim"; ${FUNCNAME[0]};;
        '3') python "3.7-slim"; ${FUNCNAME[0]};;
        '4') python "3.10"; ${FUNCNAME[0]};;
        '5') python "3.9"; ${FUNCNAME[0]};;
        '6') python "3.7"; ${FUNCNAME[0]};;
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
(1)RUN $(textyellow "OpenJDK") $(textgreen '11')
(2)RUN $(textyellow "OpenJDK") $(textgreen '17')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') openjdk "11"; ${FUNCNAME[0]};;
        '2') openjdk "17"; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_developer;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}
