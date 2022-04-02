#!/bin/bash

# VARIABLES
# DOCKER_MY_HOME="C:/Users/your_name/docker" is set as environmental variable
DOCKER_NETWORK_NAME='docker-net'

source ./scripts/docker.sh
source ./scripts/echo.sh
source ./scripts/postgres.sh
source ./scripts/ddojo.sh
source ./scripts/mobsf.sh
source ./scripts/zap.sh
source ./scripts/pentest.sh
source ./scripts/jenkins.sh

# DEVELOPER SUB-MENU
submenu_developer () {
    PS3='>> [UNDER CONSTRUCTION] DEVELOPER Tools: '
    options=('JRE' 'NPM' 'QUIT')
    select opt in "${options[@]}"
    do
        case $opt in
            'JRE')
                echo -e '\n>>> JRE'
                submenu_todo
                ;;
            'NPM')
                echo -e '\n>>> NPM'
                submenu_todo
                ;;
            'QUIT')
                PS3='> MAIN MENU: '
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# DEVOPS SUB-MENU
submenu_devops () {
    PS3='>> DEVOPS Tools: '
    options=('JENKINS' 'POSTGRES' 'DEBIAN' '' '' 'QUIT')
    select opt in "${options[@]}"
    do
        case $opt in
            'JENKINS')
                echo -e '\n>>> JENKINS'
                submenu_todo
                ;;
            'POSTGRES')
                echo -e '\n>>> POSTGRES'
                submenu_psql
                ;;
            'DEBIAN')
                echo -e '\n>>> DEBIAN'
                submenu_todo
                ;;
            '')
                echo -e '\n>>>'
                submenu_todo
                ;;
            '')
                echo -e '\n>>> '
                submenu_todo
                ;;
            'QUIT')
                PS3='> MAIN MENU: '
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

# SECURITY SUB-MENU
submenu_security () {
    PS3='>> SECURITY Tools: '
    options=('DEFECT-DOJO' 'DEPENDENCY-TRACK' 'MOBSF' 'ZAP' 'PENTEST' 'QUIT')
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
            'ZAP')
                echo -e '\n>>> ZAP'
                submenu_zap
                ;;
            'PENTEST')
                echo -e '\n>>> PENTEST'
                submenu_pt
                ;;
            'QUIT')
                PS3='> MAIN MENU: '
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
docker_network
psql_cli
echo ''

# MAIN MENU
PS3="> MAIN MENU: "
options=('SECURITY' 'DEVOPS' 'DEVELOPER' 'DOCKER FULL STOP' '' 'QUIT')
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
        '')
            echo -e '\n>>> '
            submenu_todo
            ;;
        'QUIT')
            echo -e '\n[QUIT] Bye-bye.'
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
