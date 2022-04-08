# RUN DOCKER SCRIPT  
  
**Easy-to-use compilation of scripts to run tools as Docker containers.**  
  
---
Includes categorized services  
  
```dart
╦═[SECURITY]═╦═[DEFECT-DOJO]
║            ╠═[DEPENDENCY-TRACK]
║            ╠═[MOBSF]
║            ╠═[ZAP]
║            ║
║            ╠═[PENTEST]═╦═[JUICE-SHOP]
║            ║           ╠═[DVWA]
║            ║           ╚═[VAMPI]
║            ║
║            ╚═[SAST]══════[SEMGREP]
║
╠═[DEVOPS]═══╦═[DEBIAN]
║            ╠═[JENKINS]
║            ╚═[POSTGRES]
║
╚═[DEV]══════╦═[PYTHON]
             ╚═[?]
```
---
### Requirements:  
`bash` - Shell  
`Docker` - CLI Container management  
`psql` - CLI Postgres management  
### Configuration:  
**Environment variables**  
DOCKER_MY_HOME=  
  
*WinOS:* `C:/Users/your_name/docker`  
*Linux:* `/home/your_name/docker`  
*MacOS:* `/home/your_name/docker`  
  
### References:  
**SECURITY:**  
[DEFECT-DOJO (https://github.com/DefectDojo/django-DefectDojo)](https://github.com/DefectDojo/django-DefectDojo)  
[DEPENDENCY-TRACK (https://github.com/DependencyTrack/dependency-track)](https://github.com/DependencyTrack/dependency-track)  
[MOBSF (https://github.com/MobSF/Mobile-Security-Framework-MobSF)](https://github.com/MobSF/Mobile-Security-Framework-MobSF)  
[ZAP (https://github.com/zaproxy/zaproxy)](https://github.com/zaproxy/zaproxy)  
  
**PENTEST:**  
Vulnerable applications playground collection  
[JUICE-SHOP (https://github.com/juice-shop/juice-shop)](https://github.com/juice-shop/juice-shop)  
[DVWA (https://github.com/digininja/DVWA)](https://github.com/digininja/DVWA)  
[VAMPI (https://github.com/erev0s/VAmPI)](https://github.com/erev0s/VAmPI)  
  
**SAST:**  
Static Application Security Testing tools collection  
[SEMGREP (https://hub.docker.com/r/returntocorp/semgrep-agent)](https://hub.docker.com/r/returntocorp/semgrep-agent)  
  
**DEVOPS:**  
[DEBIAN (https://hub.docker.com/_/debian)](https://hub.docker.com/_/debian)  
[JENKINS (https://hub.docker.com/_/jenkins)](https://hub.docker.com/_/jenkins)  
[POSTGRES (https://hub.docker.com/_/postgres)](https://hub.docker.com/_/postgres)  
  
**DEV:**  
Developer tools collection  
[PYTHON (https://hub.docker.com/_/python)](https://hub.docker.com/_/python)  
