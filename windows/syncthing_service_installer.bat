@echo off
echo Will install the Syncthing service using nssm...
echo This needs to be run as an administrator!
cd /d %~dp0
pause
echo.
nssm.exe install Syncthing %SYSTEMDRIVE%\Syncthing\syncthing.exe
nssm.exe set Syncthing AppParameters -home %SYSTEMDRIVE%\Syncthing\config
nssm.exe set Syncthing DisplayName Syncthing
nssm.exe set Syncthing Description Syncthing service.  Use nssm edit syncthing to edit
rem nssm.exe set Syncthing AppEnvironmentExtra STTRACE=net
nssm.exe set Syncthing Start SERVICE_DEMAND_START
echo.
echo Done!
echo use "nssm.exe remove syncthing" to delete service!
echo or "nssm.exe edit snycthing" to edit the service!
pause
echo creating directories in syncthing home (c:\syncthing\tools c:\syncthing\config)
mkdir c:\syncthing\tools 
mkdir c:\syncthing\config
pause