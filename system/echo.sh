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
        echo -e "[ERROR] Something wrong."
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
        return 0
    fi
    textred "[FAIL] ${1}"
    return 0
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

submenu_todo () {
    textgrey_bg '[UNDER CONSTRUCTION]'
    return 1
}
