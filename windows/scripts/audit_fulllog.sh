#!/usr/bin/bash
echo "****************************************" && find /cygdrive/c/Syncthing/config/ -name "audit*" | sort -r | head -1 && echo "****************************************";
find /cygdrive/c/Syncthing/config/ -name "audit*" | sort -r | head -1 | xargs tail -n 500 -f 