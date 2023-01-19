# RUN DOCKER SCRIPT  
  
**Easy-to-use compilation of scripts to run tools as Docker containers.**  
  
---
Includes categorized services  
  
```dart
╦═[SECURITY]═╦═[SERVICES]══╦═[DEFECT-DOJO]
║            ║             ╠═[DEPENDENCY-TRACK]
║            ║             ╠═[MOBSF]
║            ║             ╠═[MOZILLA-OBSERVATORY]
║            ║             ╠═[CSP-PROCESSOR]
║            ║             ╚═[TRIVY]
║            ║
║            ╠═[TOOLS]═════╦═[ZAP]
║            ║             ╠═[SEMGREP]
║            ║             ╠═[CATS]
║            ║             ╠═[TRUFFLEHOG]
║            ║             ╠═[TRIVY]
║            ║             ╠═[GITLEAKS]
║            ║             ╠═[DETECT-SECRETS]
║            ║             ╚═[DEPENDENCY-CHECK]
║            ║
║            ╚═[VULN-APPS]═╦═[JUICE-SHOP]
║                          ╠═[DVWA]
║                          ╚═[VAMPI]
║
╠═[DEVOPS]═══╦═[ALPINE]
║            ╠═[DEBIAN]
║            ╠═[JENKINS]
║            ╠═[POSTGRES]
║            ╠═[REDIS]
║            ╚═[JIRA]
║
╚═[DEV]══════╦═[PYTHON]═══[3.7|3.9|3.10]
             ╠═[NODEJS]═══[11|14|16|17|18]
             ╠═[JDK]══════[11|17]
             ╚═[MAVEN]

══[TODO]═════╦═[GITLEAKS]
             ╠═[VWAD]
             ╠═[HASHICORP-VAULT]
             ╠═[GITLAB-CI]
             ╚═[GITHAB-ACTIONS]
```
---
### Requirements:  
`bash` - Shell  
`docker` - CLI Container management  
`psql` - CLI Postgres management  
`git` - CLI Git tool  
### Configuration:  
**Environment variables**  
DOCKER_MY_HOME=  
  
*WinOS:* `C:/Users/your_name/docker`  
*Linux:* `/home/your_name/docker`  
*MacOS:* `/home/your_name/docker`  
  
---
### References:  
**SECURITY SERVICES:**  
[DEFECT-DOJO (https://github.com/DefectDojo/django-DefectDojo)](https://github.com/DefectDojo/django-DefectDojo)  
[DEPENDENCY-TRACK (https://github.com/DependencyTrack/dependency-track)](https://github.com/DependencyTrack/dependency-track)  
[MOBSF (https://github.com/MobSF/Mobile-Security-Framework-MobSF)](https://github.com/MobSF/Mobile-Security-Framework-MobSF)  
[MOZILLA-OBSERVATORY (https://github.com/mozilla/http-observatory)](https://github.com/mozilla/http-observatory)  
[CSP-PROCESSOR (https://hub.docker.com/r/ixdotai/csp)](https://hub.docker.com/r/ixdotai/csp)  
[TRIVY (https://hub.docker.com/r/aquasec/trivy)](https://hub.docker.com/r/aquasec/trivy)  
  
**SECURITY TOOLS:**  
[ZAP (https://hub.docker.com/r/owasp/zap2docker-stable)](https://hub.docker.com/r/owasp/zap2docker-stable)  
[SEMGREP (https://hub.docker.com/r/returntocorp/semgrep-agent)](https://hub.docker.com/r/returntocorp/semgrep-agent)  
[CATS (https://github.com/Endava/cats)](https://github.com/Endava/cats)  
[TRUFFLEHOG (https://hub.docker.com/r/trufflesecurity/trufflehog)](https://hub.docker.com/r/trufflesecurity/trufflehog)  
[TRIVY (https://hub.docker.com/r/aquasec/trivy)](https://hub.docker.com/r/aquasec/trivy)  
[GITLEAKS (https://hub.docker.com/r/zricethezav/gitleaks)](https://hub.docker.com/r/zricethezav/gitleaks)  
[DETECT-SECRETS (https://github.com/Yelp/detect-secrets)](https://github.com/Yelp/detect-secrets)  
[DEPENDENCY-CHECK (https://hub.docker.com/r/owasp/dependency-check)](https://hub.docker.com/r/owasp/dependency-check)  
  
**PENTEST:**  
Vulnerable applications playground collection  
[JUICE-SHOP (https://github.com/juice-shop/juice-shop)](https://github.com/juice-shop/juice-shop)  
[DVWA (https://github.com/digininja/DVWA)](https://github.com/digininja/DVWA)  
[VAMPI (https://github.com/erev0s/VAmPI)](https://github.com/erev0s/VAmPI)  
  
**DEVOPS:**  
[DEBIAN (https://hub.docker.com/_/debian)](https://hub.docker.com/_/debian)  
[ALPINE (https://hub.docker.com/_/alpine)](https://hub.docker.com/_/alpine)  
[JENKINS (https://hub.docker.com/_/jenkins)](https://hub.docker.com/_/jenkins)  
[POSTGRES (https://hub.docker.com/_/postgres)](https://hub.docker.com/_/postgres)  
[REDIS (https://hub.docker.com/_/redis)](https://hub.docker.com/_/redis)  
[JIRA (https://hub.docker.com/r/atlassian/jira-software)](https://hub.docker.com/r/atlassian/jira-software)  
  
**DEV:**  
Developer tools collection  
[PYTHON (https://hub.docker.com/_/python)](https://hub.docker.com/_/python)  
[NODEJS (https://hub.docker.com/_/node)](https://hub.docker.com/_/node)  
[OPENJDK (https://hub.docker.com/_/openjdk)](https://hub.docker.com/_/openjdk)  
[MAVEN (https://hub.docker.com/_/maven)](https://hub.docker.com/_/maven)  
  
**TODO:**  
[VWAD (https://github.com/OWASP/OWASP-VWAD)](https://github.com/OWASP/OWASP-VWAD)  
[GITLEAKS (?)](?)
  