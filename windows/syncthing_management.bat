 @ECHO OFF
rem curl -X POST -H "X-API-Key: [key]" http://localhost:8080/rest/system/reset?folder=[foldername]
SET servname=Syncthing
:TOP
CLS
:MENU
SET M=-1
SET LASTMENU=TOP
ECHO .................................
ECHO    -- %servname% -- management && %~dp0nssm status %servname%
ECHO .................................
ECHO 1 - START %servname%
ECHO 2 - STOP  %servname%
ECHO 3 - RESTART %servname%
ECHO 4 - (L)ogfile
ECHO 5 - (S)tatus
ECHO 7 - (A)dmin screen
ECHO 6 - (G)UI Management Page
ECHO 8 - (Q)UIT
ECHO.
SET /P M=Type selection then press ENTER: 
ECHO.
IF /I "%M%"=="1" GOTO :START
IF /I "%M%"=="2" GOTO :STOP
IF /I "%M%"=="3" GOTO :RESTART
IF /I "%M%"=="r" GOTO :RESTART
IF /I "%M%"=="4" GOTO :LOGFILE
IF /I "%M%"=="l" GOTO :LOGFILE
IF /I "%M%"=="5" GOTO :STATUS
IF /I "%M%"=="s" GOTO :STATUS
IF /I "%M%"=="6" GOTO :MANPAGE
IF /I "%M%"=="7" GOTO :AUDITMENU
IF /I "%M%"=="a" GOTO :AUDITMENU
IF /I "%M%"=="g" GOTO :MANPAGE
IF /I "%M%"=="8" GOTO :EXIT
IF /I "%M%"=="q" GOTO :EXIT

GOTO :TOP

:AUDITMENU
CLS
SET M=-1
SET LASTMENU=AUDITMENU
ECHO .................................
ECHO    -- %servname% -- AUDIT screen && %~dp0nssm status %servname%
ECHO .................................
ECHO 1 - Full Audit Log
ECHO 2 - ItemFinished (incoming file added or updated)
ECHO 3 - (M)ain Menu / (H)ome
ECHO 4 - Show junk files
ECHO 5 - Delete junk files 
ECHO 6 - (N)uke firewall settings
ECHO 7 - Restart Network Adapter
ECHO 8 - Show IPCONFIG /all
ECHO 9 - (G)UI Management Page
ECHO 0 - (Q)UIT
ECHO.
SET /P M=Type selection then press ENTER: 
ECHO.
IF /I "%M%"=="1" GOTO :AUDIT_FULLLOG
IF /I "%M%"=="2" GOTO :AUDIT_ITEMFINISHED
IF /I "%M%"=="3" GOTO :TOP
IF /I "%M%"=="4" GOTO :ADMIN_JUNKFILES
IF /I "%M%"=="5" GOTO :ADMIN_DELETE_JUNKFILES
IF /I "%M%"=="6" GOTO :ADMIN_NUKE_FIREWALL
IF /I "%M%"=="n" GOTO :ADMIN_NUKE_FIREWALL
IF /I "%M%"=="7" GOTO :ADMIN_RESTART_NETWORKING
IF /I "%M%"=="8" GOTO :IPCONFIG
IF /I "%M%"=="g" GOTO :MANPAGE
IF /I "%M%"=="9" GOTO :MANPAGE
IF /I "%M%"=="0" GOTO :EXIT
IF /I "%M%"=="m" GOTO :TOP
IF /I "%M%"=="h" GOTO :TOP
IF /I "%M%"=="q" GOTO :EXIT

GOTO :AUDITMENU



:START
net start %servname% /y || echo An error has occurred while starting the %servname% services
pause
GOTO :%LASTMENU%

:STOP
net stop %servname% /y || echo An error has occurred while starting the %servname% services
pause
GOTO :%LASTMENU%

:RESTART
net stop %servname% /y || echo An error has occurred while starting the %servname% services
net start %servname% /y || echo An error has occurred while starting the %servname% services
pause
GOTO :%LASTMENU%

:LOGFILE
echo launching logfile via cygwin...
start %HOMEDRIVE%\cygwin64\bin\mintty.exe  -i /Cygwin-Terminal.ico -w max /bin/env CHERE_INVOKING=1 /bin/bash -l -c 'tail -n 100 -f /cygdrive/c/Syncthing/config/syncthing.log'
GOTO :%LASTMENU%

:STATUS
sc query %servname%
pause
GOTO :%LASTMENU%

:MANPAGE
start https://127.0.0.1:8080
GOTO :%LASTMENU%

:AUDIT_FULLLOG
echo launching via cygwin...
start %HOMEDRIVE%\cygwin64\bin\mintty.exe  -i /Cygwin-Terminal.ico -w max /bin/env CHERE_INVOKING=1 /bin/bash -l -c '/cygdrive/c/Syncthing/tools/windows_shared/scripts/audit_fulllog.sh'
GOTO :AUDITMENU

:AUDIT_ITEMFINISHED
echo launching via cygwin...
start %HOMEDRIVE%\cygwin64\bin\mintty.exe  -i /Cygwin-Terminal.ico -w max /bin/env CHERE_INVOKING=1 /bin/bash -l -c '/cygdrive/c/Syncthing/tools/windows_shared/scripts/audit_itemfinished.sh'
GOTO :AUDITMENU

:ADMIN_JUNKFILES
echo launching via cygwin...
start %HOMEDRIVE%\cygwin64\bin\mintty.exe  -i /Cygwin-Terminal.ico -w max /bin/env CHERE_INVOKING=1 /bin/bash -l -c '/cygdrive/c/Syncthing/tools/windows_shared/scripts/admin_showjunkfiles.sh'
GOTO :AUDITMENU

:ADMIN_DELETE_JUNKFILES
echo launching via cygwin...
start %HOMEDRIVE%\cygwin64\bin\mintty.exe  -i /Cygwin-Terminal.ico -w max /bin/env CHERE_INVOKING=1 /bin/bash -l -c '/cygdrive/c/Syncthing/tools/windows_shared/scripts/admin_showjunkfiles_anddelete.sh'
GOTO :AUDITMENU

:ADMIN_NUKE_FIREWALL
echo nuking the firewall settings...
msiexec.exe /x{D2B9C003-A3CD-44A0-9DE5-52FE986C03E5} EPOSPAWNED=True 
goto :ADMIN_RESTART_NETWORKING

:ADMIN_RESTART_NETWORKING
echo restarting wireless network adapter (Wireless Network Connection)...
netsh interface set interface "Wireless Network Connection" admin=disable
echo disabled
netsh interface set interface "Wireless Network Connection" admin=enable
echo enabled
pause
GOTO :AUDITMENU

:IPCONFIG
ipconfig /all
echo.
pause
GOTO :AUDITMENU

:EXIT
echo If you can see this, you may have to close the CYGWIN screen
exit