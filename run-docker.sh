#!/bin/bash

# VARIABLES
# DOCKER_MY_HOME="C:/Users/your_name/docker" is set as environmental variable
DOCKER_NETWORK_NAME='mylocal'

# System
source ./system/docker.sh
source ./system/echo.sh
source ./system/colors.sh

# Menus
source ./system/menus/main_menu.sh
source ./system/menus/sub_security.sh
source ./system/menus/sub_devops.sh
source ./system/menus/sub_dev.sh


# SECURITY
source ./containers/security/services/ddojo.sh
source ./containers/security/services/dtrack.sh
source ./containers/security/services/mobsf.sh
source ./containers/security/services/observatory.sh
source ./containers/security/services/csp.sh
source ./containers/security/services/trivy.sh

source ./containers/security/tools/cats.sh
source ./containers/security/tools/dcheck.sh
source ./containers/security/tools/semgrep.sh
source ./containers/security/tools/trufflehog.sh
source ./containers/security/tools/zap.sh

source ./containers/security/vulnapps.sh


# DEVOPS
source ./containers/devops/alpine.sh
source ./containers/devops/debian.sh
source ./containers/devops/jenkins.sh
source ./containers/devops/postgres.sh
source ./containers/devops/redis.sh
source ./containers/devops/jira.sh

# DEVTOOLS
source ./containers/dev/runtimes.sh

# START HERE ->
date
docker_check
docker_home_check
docker_network
psql_cli_check

mainmenu
