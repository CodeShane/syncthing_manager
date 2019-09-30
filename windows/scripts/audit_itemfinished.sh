#!/usr/bin/bash
filename=$(find /cygdrive/c/Syncthing/config/ -name "audit*" | sort -r | head -1);
printf "searching last 10,000 lines of: \n$filename \ntotal rows: " && wc -l  < $filename
printf "\n\ndate,time,action,error,type,folder,item" | awk -F, '{for(i=1;i<=NF;i++){printf "%-15s", $i};printf "\n"}';
echo "===============,===============,===============,===============,===============,===============,===============" | awk -F, '{for(i=1;i<=NF;i++){printf "%-15s", $i};printf "\n"}';
#next line find the latest audit file and breaks down the json using jq.  output is passed to awk to turn into 15 char columns
tail $filename -n 10000 -f | grep --line-buffered "ItemFinished" | jq -r --unbuffered '[.time[0:10],.time[11:19],.data.action,.data.error,.data.type,.data.folder,.data.item] | join(",")' | awk -F, '{for(i=1;i<=NF;i++){printf "%-15s", $i};printf "\n"}';

