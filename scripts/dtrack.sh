#!/bin/bash

# DEPENDENCY-TRACK SUB-MENU
submenu_dt () {
    local PS3='>>> DEPENDENCY-TRACK Controls: '
    local options=('START' 'STOP' 'INITIALIZE' 'STATUS' 'DELETE' 'QUIT')
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            'START')
                dt_start
                ;;
            'STOP')
                dt_stop
                ;;
            'INITIALIZE')
                dt_init
                ;;
            'STATUS')
                dt_status
                ;;
            'DELETE')
                dt_delete
                ;;
            'QUIT')
                PS3='\n>> SECURITY Tools: '
                return
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}
