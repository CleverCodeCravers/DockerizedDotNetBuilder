# DockerizedDotNetBuilder
Research for a docker based build of a .Net application

## Beschreibung
Das DockerizedDotNetBuilder-Projekt zielt darauf ab, eine .NET 6-Anwendung innerhalb eines Docker-Containers zu bauen und das Ergebnis als ZIP-Datei außerhalb des Containers bereitzustellen. 

## Voraussetzungen
- Docker

## Ablauf

1. Der Benutzer startet ein Skript oder so.
2. Dieses Skript startet den vorbereiteten docker-Container mit der Git-URL
3. Der Container clont sich intern das Repository
4. Der Inhalt des Repositories wird gebaut
5. Die Unit Tests im Projekt werden ausgeführt
6. Schlagen die Unit Tests fehl, wird abgebrochen (der docker container legt das Build Log ab und beendet sich ohne Ergebnis)
7. Ansonsten wird ein Powershell-Skript gestartet, dass die "Artefakte" einsammelt und außerhalb des Docker containers als Zip ablegt, inkl. Build log und sich dann beendet

## Experiment
- Kann der docker-Container unter Linux laufen und dennoch für Windows übersetzen?
