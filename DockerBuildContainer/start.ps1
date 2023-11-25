# Überprüfen, ob eine Git-URL angegeben wurde
param(
    [Parameter(Mandatory = $true)]
    [string]$GitUrl
)

# Klont das Repository
git clone $GitUrl repo

# Wechselt in das Repository-Verzeichnis
Set-Location repo

# Create output folders for Linux and Windows
$linuxOutputFolder = "/app/output/linux"
$windowsOutputFolder = "/app/output/windows"

Write-Host "Creating output folders..."
New-Item -ItemType Directory -Force -Path $linuxOutputFolder
New-Item -ItemType Directory -Force -Path $windowsOutputFolder

$slnFiles = Get-ChildItem -Filter *.sln -Recurse

# Iterate through each .sln file and execute dotnet build
foreach ($slnFile in $slnFiles) {
    $slnPath = $slnFile.FullName
    Write-Host "Building $slnPath..."
    # Execute dotnet build for the current .sln file
    dotnet build --configuration Release $slnPath
}

$csProjFiles = Get-ChildItem -Filter *AvaloniaUI.csproj -Recurse


Write-Host "Building and publishing for Linux..."

dotnet publish $csProjFiles -c Release -o $linuxOutputFolder  -p:PublishReadyToRun=true --self-contained true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:UseAppHost=true -r linux-x64


Write-Host "Building and publishing for Windows..."

dotnet publish $csProjFiles -c Release -o $windowsOutputFolder  -p:PublishReadyToRun=true --self-contained true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:UseAppHost=true -r win-x64


# Zip the output for Linux
Write-Host "Zipping output for Linux..."
Compress-Archive -Path "$linuxOutputFolder/*" -DestinationPath "/app/output/Linux-Build.zip"

# Zip the output for Windows
Write-Host "Zipping output for Windows..."
Compress-Archive -Path "$windowsOutputFolder/*" -DestinationPath "/app/output/Windows-Build.zip"


Write-Host "Build and publish process completed."
