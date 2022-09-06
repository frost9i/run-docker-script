#!/bin/bash

# NODEJS SUB-MENU
nodejs_menu () {
    HEADING='NODEJS'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)RUN $(textgreen 'Node').$(textyellow 'JS') $(textgreen 'v.11')
(2)RUN $(textgreen 'Node').$(textyellow 'JS') $(textgreen 'v.14')
(3)RUN $(textgreen 'Node').$(textyellow 'JS') $(textgreen 'v.16')
(4)RUN $(textgreen 'Node').$(textyellow 'JS') $(textgreen 'v.17')
(5)RUN $(textgreen 'Node').$(textyellow 'JS') $(textgreen 'v.18')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') nodejs "11"; ${FUNCNAME[0]};;
        '2') nodejs "14"; ${FUNCNAME[0]};;
        '3') nodejs "16"; ${FUNCNAME[0]};;
        '4') nodejs "17"; ${FUNCNAME[0]};;
        '5') nodejs "18"; ${FUNCNAME[0]};;
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
(1)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.7')
(2)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.9')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') python "3.7"; ${FUNCNAME[0]};;
        '2') python "3.9"; ${FUNCNAME[0]};;
        '3') python "3.10"; ${FUNCNAME[0]};;
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
