#!/bin/bash

# VARIABLES
# DOCKER_MY_HOME="C:/Users/your_name/docker" is set as environmental variable
DOCKER_NETWORK_NAME='docker-net'

# System
source ./system/menu.sh
source ./system/docker.sh
source ./system/echo.sh
source ./system/colors.sh

# SECURITY Services
source ./services/ddojo.sh
source ./services/dtrack.sh
source ./services/mobsf.sh
source ./services/observatory.sh
source ./services/sca.sh
source ./services/semgrep.sh
source ./services/zap.sh
source ./services/vulnapps.sh

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
