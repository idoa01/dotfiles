#!/bin/bash
mplayer -identify -endpos 0 -vo null -ao null "$1" 2>/dev/null | grep LENGTH | awk -v filename="$1" -F'=' '{print $2 / 60 "\t" filename }'

