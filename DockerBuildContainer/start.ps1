# Überprüfen, ob eine Git-URL angegeben wurde
param(
    [Parameter(Mandatory=$true)]
    [string]$GitUrl
)

# Klont das Repository
git clone $GitUrl repo

# Wechselt in das Repository-Verzeichnis
Set-Location repo

# Führt dotnet build aus
dotnet build
