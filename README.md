# RUN DOCKER SCRIPT  
  
**Easy-to-use compilation of scripts to run tools as Docker containers.**  
  
---
Includes categorized services  
  
```dart
╦[SECURITY]═╦[DEFECT-DOJO]
║           ╠[DEPENDENCY-TRACK]
║           ╠[MOBSF]
║           ╠[ZAP]
║           ╚[PENTEST]╦[JUICE-SHOP]
║                     ╠[DVWA]
║                     ╚[VAMPI]
║
╠[DEVOPS]═══╦[DEBIAN]
║           ╠[JENKINS]
║           ╚[POSTGRES]
║
╠[DEVELOPER]╦[?JRE]
║           ╠[?NPM]
║           ╚[?YARN]
║
╚[ETC]══════[?TBD]
```
---
### Requirements:  
`bash` - shell  
`psql` - for Postgres management  
### Configuration:  
**Environment variables**  
DOCKER_MY_HOME=  
  
*WinOS:* `C:/Users/your_name/docker`  
*Linux:* `/home/your_name/docker`  
*MacOS:* `/home/your_name/docker`  
  
### References:  
[SECURITY]:  
[DEFECT-DOJO](https://github.com/DefectDojo/django-DefectDojo)  
[DEPENDENCY-TRACK](https://github.com/DependencyTrack/dependency-track)  
[MOBSF](https://github.com/MobSF/Mobile-Security-Framework-MobSF)  
[ZAP](https://github.com/zaproxy/zaproxy)  
  
[PENTEST]:  
[JUICE-SHOP](https://github.com/juice-shop/juice-shop)  
[DVWA](https://github.com/digininja/DVWA)  
[VAMPI](https://github.com/erev0s/VAmPI)  
  
[DEVOPS]:  
[DEBIAN](https://hub.docker.com/_/debian)  
[JENKINS](https://hub.docker.com/_/jenkins)  
[POSTGRES](https://hub.docker.com/_/postgres)  
  
