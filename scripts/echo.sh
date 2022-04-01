#!/bin/bash

error1 () {
    if [ -z "${1}" ]
    then
        echo -e "[!] Something wrong."
        exit 1
    else
        echo -e "[ERROR] ${1}"
    fi
}

error2 () {
    echo -e "[?] TBD"
}

fail1 () {
    if [ -z ${1} ]
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

script_input () {
    error2
}

submenu_tbd () {
    echo -e '[UNDER CONSTRUCTION]'
}
