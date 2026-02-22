
python ./download_net_runtime.py windows

if (Test-Path bin/publish/Windows) { Remove-Item -Recurse -Force bin/publish/Windows }
if (Test-Path SS14.Launcher_Windows.zip) { Remove-Item SS14.Launcher_Windows.zip }

dotnet publish SS14.Launcher/SS14.Launcher.csproj /p:FullRelease=True -c Release --no-self-contained -r win-x64 /nologo /p:RobustILLink=true
dotnet publish SS14.Loader/SS14.Loader.csproj -c Release --no-self-contained -r win-x64 /nologo
dotnet publish SS14.Launcher.Strap/SS14.Launcher.Strap.csproj -c Release /nologo

python ./exe_set_subsystem.py "SS14.Launcher/bin/Release/net10.0/win-x64/publish/SS14.Launcher.exe" 2
python ./exe_set_subsystem.py "SS14.Loader/bin/Release/net10.0/win-x64/publish/SS14.Loader.exe" 2

New-Item -ItemType Directory -Force bin/publish/Windows/bin
New-Item -ItemType Directory -Force bin/publish/Windows/bin/loader
New-Item -ItemType Directory -Force bin/publish/Windows/dotnet
New-Item -ItemType Directory -Force bin/publish/Windows/Marsey/Mods
New-Item -ItemType Directory -Force bin/publish/Windows/Marsey/ResourcePacks

Copy-Item -Recurse Dependencies/dotnet/windows/* bin/publish/Windows/dotnet
Copy-Item "SS14.Launcher.Strap/bin/Release/net45/publish/Marseyloader.exe" bin/publish/Windows
Copy-Item "SS14.Launcher.Strap/console.bat" bin/publish/Windows
Copy-Item "SS14.Launcher/bin/Release/net10.0/win-x64/publish/*" bin/publish/Windows/bin
Copy-Item "SS14.Loader/bin/Release/net10.0/win-x64/publish/*" bin/publish/Windows/bin/loader

Compress-Archive -Path bin/publish/Windows/* -DestinationPath SS14.Launcher_Windows.zip -Force
