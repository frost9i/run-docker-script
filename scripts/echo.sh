#!/bin/bash

check1 () {
    if [[ -z "${1}" ]]
    then
        1="null"
    fi
    echo -e "[CHECK] ${1}"
}

error1 () {
    if [ -z "${1}" ]
    then
        echo -e "[ERROR] Something wrong."
        exit 1
    fi
    echo -e "[ERROR] ${1}"
}

error2 () {
    echo -e "[?] TBD"
}

fail1 () {
    if [ -z "${1}" ]
    then
        echo -e "[FAIL]"
        return 1
    fi
    echo -e "[FAIL] ${1}"
    return 1
}

skip1 () {
    if [ -z "${1}" ]
    then
        echo -e "[SKIPPED]"
    else
        echo -e "[SKIP] ${1}"
    fi
}

info1 () {
    if [[ -z "${1}" ]]
    then
        1="null"
    fi
    echo -e "[INFO] ${1}"
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
    echo -e '[UNDER CONSTRUCTION]'
    return 1
}
