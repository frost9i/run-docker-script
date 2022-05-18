# RUN DOCKER SCRIPT  
  
**Easy-to-use compilation of scripts to run tools as Docker containers.**  
  
---
Includes categorized services  
  
```dart
╦═[SECURITY]═╦═[SERVICES]══╦═[DEFECT-DOJO]
║            ║             ╠═[DEPENDENCY-TRACK]
║            ║             ╠═[MOBSF]
║            ║             ╚═[MOZILLA-OBSERVATORY]
║            ╠═[TOOLS]═════╦═[SEMGREP]
║            ║             ╠═[GITLEAKS] todo
║            ║             ╚═[ZAP]
║            ╚═[VULN-APPS]═╦═[JUICE-SHOP]
║                          ╠═[DVWA]
╠═[DEVOPS]═══╦═[DEBIAN]    ╚═[VAMPI]
║            ╠═[JENKINS]
║            ╠═[POSTGRES]
║            ╠═[REDIS]
║            ╠═[JIRA] todo
║            ╚═[VAULT] todo
╚═[DEV]══════╦═[PYTHON]═╦═[v3.9]
             ║          ╚═[v3.7]
             ╚═[NODEJS]═╦═[v18]
                        ╠═[v17]
                        ╚═[v11]
```
TODO:  
K8s  
JIRA  
VAULT  
GITLAB-CI (CI/CD)  
GITHAB-ACTIONS (CI/CD)  
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
  
**PENTEST:**  
Vulnerable applications playground collection  
[JUICE-SHOP (https://github.com/juice-shop/juice-shop)](https://github.com/juice-shop/juice-shop)  
[DVWA (https://github.com/digininja/DVWA)](https://github.com/digininja/DVWA)  
[VAMPI (https://github.com/erev0s/VAmPI)](https://github.com/erev0s/VAmPI)  
  
**SECURITY SCANNING TOOLS:**  
Static Application Security Testing tools collection  
[SEMGREP (https://hub.docker.com/r/returntocorp/semgrep-agent)](https://hub.docker.com/r/returntocorp/semgrep-agent)  
[ZAP (https://github.com/zaproxy/zaproxy)](https://github.com/zaproxy/zaproxy)  
  
**DEVOPS:**  
[DEBIAN (https://hub.docker.com/_/debian)](https://hub.docker.com/_/debian)  
[JENKINS (https://hub.docker.com/_/jenkins)](https://hub.docker.com/_/jenkins)  
[POSTGRES (https://hub.docker.com/_/postgres)](https://hub.docker.com/_/postgres)  
[REDIS (https://hub.docker.com/_/redis)](https://hub.docker.com/_/redis)  
  
**DEV:**  
Developer tools collection  
[PYTHON (https://hub.docker.com/_/python)](https://hub.docker.com/_/python)  
[NODEJS (https://hub.docker.com/_/node)](https://hub.docker.com/_/node)  
  