#!/bin/bash

# NODEJS SUB-MENU
nodejs_menu () {
    HEADING='NODEJS'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)RUN $(textgreen "NODEJS") $(textyellow 'v.11')
(2)RUN $(textgreen "NODEJS") $(textyellow 'v.14')
(3)RUN $(textgreen "NODEJS") $(textyellow 'v.16')
(4)RUN $(textgreen "NODEJS") $(textyellow 'v.17')
(5)RUN $(textgreen "NODEJS") $(textyellow 'v.18')
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
(1)RUN $(textyellow "PYTHON") $(textgreen '3.7')
(2)RUN $(textyellow "PYTHON") $(textgreen '3.9')
(Q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') python "3.7"; ${FUNCNAME[0]};;
        '2') python "3.9"; ${FUNCNAME[0]};;
        '2') python "3.10"; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_developer;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}
