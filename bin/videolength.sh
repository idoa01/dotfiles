#!/bin/bash
OLDIFS=$IFS
IFS=$(echo -en "\n\b")
#LS_PARAMS=""
#if [ -n "$1" ]
#then 
#    LS_PARAMS="\"$1\""
#fi
for f in `find . -maxdepth 1 -type f`; do mplayer -identify -endpos 0 -vo null -ao null $f 2>/dev/null | grep LENGTH | awk -v filename="$f" -F'=' '{print $2 / 60 "\t" filename }' ; done
#for f in `ls *.mp4 *.flv`; do mplayer -identify -endpos 0 -vo null -ao null $f 2>/dev/null | grep LENGTH | awk -v filename="$f" -F'=' '{print $2 / 60 " " filename }' ; done
IFS=$OLDIFS
