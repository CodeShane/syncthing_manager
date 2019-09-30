#!/usr/bin/bash
# this will print files in /cygwin/d or /cygwin/x that are ~.*x (temp MS office docs) or conflict files
#linux version... maybe build lateR: find /mnt/hd2/backups/ \! -readable -prune -name "~*.*x" -o -name "*sync-conflict-*" -type f -exec rm -i {} \;
find /cygdrive/c/Syncthing/tools/personal_sync/ /cygdrive/c/Syncthing/tools/memsql_shared/ /cygdrive/c/Syncthing/tools/backup_shared/ -name "~*.*x" -o -name "*sync-conflict-*" -type f -exec rm -i -v {} \;
echo done!
read -p "press any key...";
