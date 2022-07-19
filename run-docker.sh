#!/bin/bash

# VARIABLES
# DOCKER_MY_HOME="C:/Users/your_name/docker" is set as environmental variable
DOCKER_NETWORK_NAME='docker-net'

# System
source ./system/docker.sh
source ./system/echo.sh
source ./system/colors.sh

# Menus
source ./system/menus/main_menu.sh

# SECURITY Services
source ./services/security/ddojo.sh
source ./services/security/dtrack.sh
source ./services/security/mobsf.sh
source ./services/security/observatory.sh
source ./services/security/vulnapps.sh
source ./services/sca.sh
source ./services/semgrep.sh
source ./services/zap.sh

# DEVOPS Services
source ./services/jenkins.sh
source ./services/postgres.sh
source ./services/debian.sh
source ./services/redis.sh

# DEVTOOLS
source ./services/dev.sh

# START HERE ->
date
docker_check
docker_home_check
docker_network
psql_cli_check

mainmenu
