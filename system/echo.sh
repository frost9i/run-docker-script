#!/bin/bash

check1 () {
    if [[ -z "${1}" ]]
    then
        1="null"
    fi
    textyellow "[CHECK] ${1}"
}

error1 () {
    if [ -z "${1}" ]
    then
        textred "[ERROR] Something wrong."
        exit 1
    fi
    textred "[ERROR] ${1}"
}

error2 () {
    echo -e "[?] TBD"
}

fail1 () {
    if [ -z "${1}" ]
    then
        textred "[FAIL]"
        return 1
    fi
    textred "[FAIL] ${1}"
    return 1
}

skip1 () {
    if [ -z "${1}" ]
    then
        textcyan "[SKIPPED]"
    else
        textcyan "[SKIP] ${1}"
    fi
}

info1 () {
    if [[ -z "${1}" ]]
    then
        1="null"
    fi
    textgrey "[INFO] ${1}"
}

init1 () {
    if [[ -z "${1}" ]]
    then
        1="null"
    fi
    textyellow "[INIT] ${1}"
}

script_ask () {
    echo ''
    read -p "[PRESS] ${1} [y/n]: " -n 1 -r
    echo ''
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        return 0
    fi
    return 1
}

heading_service () {
    echo -ne """
$(textbluelight_bg ">> ${1}")
(1)$(textgreen 'START')   (2)$(textmagenta 'STOP')    (3)$(textyellow 'INIT')
(Q)$(textgrey 'ESC')     (S)$(textgrey 'STATUS')  (D)$(textred 'DELETE')
"""
}

heading_run () {
    echo -ne """
$(textbluelight_bg ">> ${1}")
(1)$(textgreen 'RUN')   (2)$(textcyan 'SHELL')    (3)$(textyellow 'INIT')
(Q)$(textgrey 'ESC')   (S)$(textgrey 'STATUS')   (D)$(textred 'DELETE')
"""
}

submenu_todo () {
    textgrey_bg '\n[UNDER CONSTRUCTION]'
    return 1
}

echo_port () {
    info1 "$(textmagenta http://localhost:${CONTAINER_EXPOSED_PORT})"
}
