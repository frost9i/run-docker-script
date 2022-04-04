#!/bin/bash

ESC=$(printf '\033')
RESET="${ESC}[1;0m"

# Text colors
textblack() { printf "${ESC}[1;30m${1}${RESET}\n" ; }
textred() { printf "${ESC}[1;31m${1}${RESET}\n" ; }
textgreen() { printf "${ESC}[1;32m${1}${RESET}\n" ; }
textyellow() { printf "${ESC}[1;33m${1}${RESET}\n" ; }
textblue() { printf "${ESC}[1;34m${1}${RESET}\n" ; }
textmagenta() { printf "${ESC}[1;35m${1}${RESET}\n" ; }
textcyan() { printf "${ESC}[1;36m${1}${RESET}\n" ; }
textgrey() { printf "${ESC}[1;37m${1}${RESET}\n" ; }
textdefault() { printf "${ESC}[1;39m${1}${RESET}\n" ; }
textgreydark() { printf "${ESC}[1;90m${1}${RESET}\n" ; }
textbluelight() { printf "${ESC}[1;94m${1}${RESET}\n" ; }

# Background text colors
textred_bg() { printf "${ESC}[1;41m${1}${RESET}\n" ; }
textgreen_bg() { printf "${ESC}[1;42m${1}${RESET}\n" ; }
textyellow_bg() { printf "${ESC}[1;43m${1}${RESET}\n" ; }
textblue_bg() { printf "${ESC}[1;44m${1}${RESET}\n" ; }
textmagenta_bg() { printf "${ESC}[1;45m${1}${RESET}\n" ; }
textcyan_bg() { printf "${ESC}[1;46m${1}${RESET}\n" ; }
textgrey_bg() { printf "${ESC}[1;47m${1}${RESET}\n" ; }
textbluelight_bg() { printf "${ESC}[1;104m${1}${RESET}\n" ; }

# Combinations
boldtextblue() { printf "${ESC}[1;94m${1}${RESET}\n"; }
