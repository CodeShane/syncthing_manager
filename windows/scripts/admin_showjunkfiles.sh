#!/usr/bin/bash
# this will print files in /cygwin/d or /cygwin/x that are ~.*x (temp MS office docs) or conflict files
find /cygdrive/c/Syncthing/tools/personal_sync/ /cygdrive/c/Syncthing/tools/memsql_shared/ /cygdrive/c/Syncthing/tools/backup_shared/ -name "~*.*x" -o -name "*sync-conflict-*" -type f 2>/dev/null;
read -p "press any key...";
