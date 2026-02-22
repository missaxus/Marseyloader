IF EXIST "dotnet\dotnet.exe" (
    SET DOTNET_ROOT="%CD%\dotnet"
    dotnet\dotnet.exe bin\SS14.Launcher.dll
) ELSE (
    dotnet bin\SS14.Launcher.dll
)

PAUSE
