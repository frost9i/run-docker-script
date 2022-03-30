#!/bin/bash

# DOCKER_MY_HOME="C:/Users/your_name"
# must be set as environmental variable

# VARIABLES
DOCKER_NETWORK_NAME='ffx'

source ./scripts/docker.sh
source ./scripts/network.sh
source ./scripts/postgres.sh
source ./scripts/ddojo.sh

error1 () {
    if [ -z "${1}" ]
    then
        echo -e "[!] Something wrong."
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
    else
        echo -e "[FAIL] ${1}"
    fi
}

script_ask () {
    read -p "$1 [y/n]: " -n 1 -r
    echo ''
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        return 0
    fi
    return 1
}

# PostgreSQL launch and setup submenu
submenu_psql () {
    local PS3='>> PostgreSQL Controls: '
    local options=('START Postgres' 'STOP Postgres' 'DELETE Postgres' 'STATUS' 'Return')
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            'START Postgres')
                psql_check
                ;;
            'STOP Postgres')
                psql_stop
                ;;
            'DELETE Postgres')
                psql_delete
                ;;
            'STATUS')
                psql_status
                ;;
            'Return')
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# DefectDojo launch and setup submenu
submenu_dd () {
    local PS3='>> DefectDojo Controls: '
    local options=('START DefectDojo' 'STOP DefectDojo' 'INITIALIZE DefectDojo' 'STATUS' 'DELETE DefectDojo' 'Return')
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            'START DefectDojo')
                dd_start
                ;;
            'STOP DefectDojo')
                dd_stop
                ;;
            'INITIALIZE DefectDojo')
                dd_init
                ;;
            'STATUS')
                dd_status
                ;;
            'DELETE DefectDojo')
                dd_delete
                ;;
            'Return')
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# DependencyTrack launch and setup submenu
submenu_dt () {
    local PS3='>> DependencyTrack Controls: '
    local options=('START DependencyTrack' 'STOP DependencyTrack' 'INITIALIZE DependencyTrack' 'STATUS' 'DELETE DependencyTrack' 'Return')
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            'START DependencyTrack')
                dt_start
                ;;
            'STOP DependencyTrack')
                dt_stop
                ;;
            'INITIALIZE DependencyTrack')
                dt_init
                ;;
            'STATUS')
                dt_status
                ;;
            'DELETE DependencyTrack')
                dt_delete
                ;;
            'Return')
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# START HERE ->
date
docker_check
docker_home_check
psql_cli
echo ''

# main menu
PS3='> Docker automation script MENU: '
options=('DefectDojo' 'PostgreSQL' 'DependencyTrack' 'Docker FULL STOP' 'QUIT Script')
select opt in "${options[@]}"
do
    case $opt in
        'DefectDojo')
            echo -e '\n>> DefectDojo Controls'
            submenu_dd
            ;;
        'PostgreSQL')
            echo -e '\n>> Postgres Controls'
            submenu_psql
            ;;
        'DependencyTrack')
            echo -e '\n>> DependencyTrack Controls'
            submenu_dt
            ;;
        'Docker FULL STOP')
            docker_stop
            exit
            ;;
        'QUIT Script')
            echo -e '[QUIT] Bye-bye.'
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
