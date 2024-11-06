#!/bin/bash

# VARIABLES
#! DOCKER_MY_HOME="C:/Users/your_name/docker" is set as environmental variable
DOCKER_NETWORK_NAME='mylocal'

# SYSTEM
source ./system/docker.sh
source ./system/echo.sh
source ./system/colors.sh

# MENUS
source ./system/menus/main_menu.sh
source ./system/menus/sub_security.sh
source ./system/menus/sub_devops.sh
source ./system/menus/sub_dev.sh


# SECURITY
## Services
source ./containers/security/services/ddojo.sh
source ./containers/security/services/dtrack.sh
source ./containers/security/services/mobsf.sh
source ./containers/security/services/observatory.sh
source ./containers/security/services/csp.sh
source ./containers/security/services/trivy.sh

## Tools
source ./containers/security/tools/cats.sh
source ./containers/security/tools/cdxgen.sh
source ./containers/security/tools/clair.sh
source ./containers/security/tools/dcheck.sh
source ./containers/security/tools/detect-secrets.sh
source ./containers/security/tools/gitleaks.sh
source ./containers/security/tools/semgrep.sh
source ./containers/security/tools/syft.sh
source ./containers/security/tools/trufflehog.sh
source ./containers/security/tools/zap.sh
## Vulnerable applications
source ./containers/security/vulnapps.sh

# DEVOPS

## Services
source ./containers/devops/jenkins.sh
source ./containers/devops/postgres.sh
source ./containers/devops/redis.sh
source ./containers/devops/jira.sh
## Tools
source ./containers/devops/postgres_client.sh
## Shells
source ./containers/devops/alpine.sh
source ./containers/devops/debian.sh

# Runtimes
source ./containers/dev/runtimes.sh

# START HERE ->
date
docker_check
docker_home_check
docker_mount_check # $DOCKER_MY_HOME/git
docker_network
psql_cli_check

mainmenu
