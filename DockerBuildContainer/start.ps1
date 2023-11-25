# Überprüfen, ob eine Git-URL angegeben wurde
param(
    [Parameter(Mandatory = $true)]
    [string]$GitUrl
)

# Klont das Repository
git clone $GitUrl repo

# Wechselt in das Repository-Verzeichnis
Set-Location repo

$slnFiles = Get-ChildItem -Filter *.sln -Recurse

# Iterate through each .sln file and execute dotnet build
foreach ($slnFile in $slnFiles) {
    $slnPath = $slnFile.FullName
    Write-Host "Building $slnPath..."
    # Execute dotnet build for the current .sln file
    dotnet build --configuration Release $slnPath
}

$csProjFiles = Get-ChildItem -Filter *AvaloniaUI.csproj -Recurse


dotnet publish $csProjFiles -c Release -o "/app/output"  -p:PublishReadyToRun=true --self-contained true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:UseAppHost=true

