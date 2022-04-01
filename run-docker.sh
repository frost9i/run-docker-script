#!/bin/bash

# DOCKER_MY_HOME="C:/Users/your_name/docker"
# must be set as environmental variable

# VARIABLES
DOCKER_NETWORK_NAME='docker-net'

source ./scripts/docker.sh
source ./scripts/network.sh
source ./scripts/postgres.sh
source ./scripts/ddojo.sh
source ./scripts/mobsf.sh
source ./scripts/pentest.sh
source ./scripts/jenkins.sh
source ./scripts/echo.sh

# PostgreSQL launch and setup submenu
submenu_psql () {
    local PS3='>>> POSTGRES Controls: '
    local options=('START Postgres' 'STOP Postgres' 'DELETE Postgres' 'STATUS' 'QUIT')
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
            'QUIT')
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# DefectDojo launch and setup submenu
submenu_dd () {
    local PS3='>> DefectDojo Controls: '
    local options=('START DefectDojo' 'STOP DefectDojo' 'INITIALIZE DefectDojo' 'STATUS' 'DELETE DefectDojo' 'QUIT')
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
            'QUIT')
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# DependencyTrack launch and setup submenu
submenu_dt () {
    local PS3='>> DependencyTrack Controls: '
    local options=('START DependencyTrack' 'STOP DependencyTrack' 'INITIALIZE DependencyTrack' 'STATUS' 'DELETE DependencyTrack' 'QUIT')
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
            'QUIT')
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

# DEVELOPER SUB-MENU
submenu_developer () {
    PS3='>> [UNDER CONSTRUCTION] DEVELOPER Tools: '
    options=('JRE' 'NPM' 'QUIT')
    select opt in "${options[@]}"
    do
        case $opt in
            'JRE')
                echo -e '\n>>> JRE'
                submenu_tbd
                ;;
            'NPM')
                echo -e '\n>>> NPM'
                submenu_tbd
                ;;
            'QUIT')
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# DEVOPS SUB-MENU
submenu_devops () {
    PS3='>> DEVOPS Tools: '
    options=('JENKINS' 'POSTGRES' 'QUIT')
    select opt in "${options[@]}"
    do
        case $opt in
            'JENKINS')
                echo -e '\n>>> JENKINS'
                submenu_jenkins
                ;;
            'POSTGRES')
                echo -e '\n>>> POSTGRES'
                submenu_psql
                ;;
            'QUIT')
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# SECURITY SUB-MENU
submenu_security () {
    PS3='>> SECURITY Tools: '
    options=('DEFECT-DOJO' 'DEPENDENCY-TRACK' 'MOBSF' 'PENTEST' 'QUIT')
    select opt in "${options[@]}"
    do
        case $opt in
            'DEFECT-DOJO')
                echo -e '\n>>> DEFECT-DOJO'
                submenu_dd
                ;;
            'DEPENDENCY-TRACK')
                echo -e '\n>>> DEPENDENCY-TRACK'
                submenu_dt
                ;;
            'MOBSF')
                echo -e '\n>>> MOBSF'
                submenu_mobsf
                ;;
            'PENTEST')
                echo -e '\n>>> PENTEST'
                submenu_pt
                ;;
            'QUIT')
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# MAIN MENU
PS3='> MAIN MENU Docker script: '
options=('SECURITY' 'DEVOPS' 'DEVELOPER' 'DOCKER FULL STOP' 'QUIT')
select opt in "${options[@]}"
do
    case $opt in
        'SECURITY')
            echo -e '\n>> SECURITY Tools'
            submenu_security
            ;;
        'DEVOPS')
            echo -e '\n>> DEVOPS Tools'
            submenu_devops
            ;;
        'DEVELOPER')
            echo -e '\n>> DEVELOPER Tools'
            submenu_developer
            ;;
        'DOCKER FULL STOP')
            docker_stop
            exit
            ;;
        'QUIT')
            echo -e '[QUIT] Bye-bye.'
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
