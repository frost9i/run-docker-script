#!/bin/bash

# NODEJS SUB-MENU
nodejs_menu () {
    HEADING='NODEJS'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1) NodeJS $(textgreen 'v.23')
(2) NodeJS $(textgreen 'v.22')
(3) NodeJS $(textgreen 'v.21')
(4) NodeJS $(textgreen 'v.20')
(5) NodeJS $(textgreen 'v.18')
(6) NodeJS $(textgreen 'v.17')
(7) NodeJS $(textgreen 'v.16')
(8) NodeJS $(textgreen 'v.14')
(9) NodeJS $(textgreen 'v.11')

(q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') nodejs "23"; ${FUNCNAME[0]};;
        '2') nodejs "22"; ${FUNCNAME[0]};;
        '3') nodejs "21"; ${FUNCNAME[0]};;
        '4') nodejs "20"; ${FUNCNAME[0]};;
        '5') nodejs "18"; ${FUNCNAME[0]};;
        '6') nodejs "17"; ${FUNCNAME[0]};;
        '7') nodejs "16"; ${FUNCNAME[0]};;
        '8') nodejs "14"; ${FUNCNAME[0]};;
        '9') nodejs "11"; ${FUNCNAME[0]};;
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
(1)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.14-slim')
(2)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.13-slim')
(3)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.12-slim')
(4)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.9-slim')
(5)RUN $(textblue "Py")$(textyellow "thon") $(textgreen '3.7-slim')

(q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') python "3.14-slim"; ${FUNCNAME[0]};;
        '2') python "3.13-slim"; ${FUNCNAME[0]};;
        '3') python "3.12-slim"; ${FUNCNAME[0]};;
        '4') python "3.9-slim"; ${FUNCNAME[0]};;
        '5') python "3.7-slim"; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_developer;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# PYTHON SUB-MENU
openjdk_menu () {
    HEADING='Java'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)RUN $(textyellow "Java") $(textgreen '22')
(2)RUN $(textyellow "Java") $(textgreen '21')
(3)RUN $(textyellow "Java") $(textgreen '17')
(4)RUN $(textyellow "Java") $(textgreen '11')

(q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') java "22"; ${FUNCNAME[0]};;
        '2') java "21"; ${FUNCNAME[0]};;
        '3') java "17"; ${FUNCNAME[0]};;
        '4') java "11"; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_developer;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}

# GOLANG SUB-MENU
# https://hub.docker.com/_/golang
go_menu () {
    HEADING='GoLang'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)RUN $(textyellow "Go") $(textgreen '1.24-alpine')
(2)RUN $(textyellow "Go") $(textgreen '1.23-alpine')
(3)RUN $(textyellow "Go") $(textgreen '1.22-alpine')

(q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') go "1.24-alpine"; ${FUNCNAME[0]};;
        '2') go "1.23-alpine"; ${FUNCNAME[0]};;
        '3') go "1.22-alpine"; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_developer;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}


# RUBY SUB-MENU
# https://hub.docker.com/_/ruby
ruby_menu () {
    HEADING='Ruby'
    echo -ne """
$(textcyan_bg ">> ${HEADING}")
(1)RUN $(textred "Ruby") $(textyellow '3.3.8-alpine')

(q)$(textgrey 'ESC')
"""
    read -p ">> ${HEADING}: " -rn 1; echo ''
    case ${REPLY} in
        '1') ruby "3.3.8-alpine"; ${FUNCNAME[0]};;
        [Q]) exit;;
        [q]) submenu_developer;;
        *) textred "invalid option $REPLY"; ${FUNCNAME[0]};;
    esac
}
