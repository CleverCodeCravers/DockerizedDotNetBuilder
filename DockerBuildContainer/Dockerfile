# Verwenden des offiziellen Microsoft .NET 6 SDK Images
FROM mcr.microsoft.com/dotnet/sdk:7.0

# Setzen des Arbeitsverzeichnisses im Container
WORKDIR /app

# Installieren von PowerShell Core
RUN apt-get update && \
    apt-get install -y wget apt-transport-https software-properties-common && \
    wget -q "https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y powershell

# Installieren von Git
RUN apt-get install -y git

# Kopieren des PowerShell-Startskripts in den Container
COPY start.ps1 /app/start.ps1

# Setzen des Ausgabeordners
ENV OUTPUT_PATH /app/output

# Erstellen des Ausgabeordners
RUN mkdir $OUTPUT_PATH

# Setzen von PowerShell als Einstiegspunkt
ENTRYPOINT ["pwsh", "-File", "/app/start.ps1"]
