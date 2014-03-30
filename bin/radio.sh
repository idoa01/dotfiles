#!/bin/bash
# Copyright (C) 2004 Ido
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, you can either send email to this
# program's maintainer or write to: The Free Software Foundation,
# Inc.; 59 Temple Place, Suite 330; Boston, MA 02111-1307, USA.

## Command variables

DIALOG=whiptail
PLAYCOMMAND='xterm -iconic -title Radio -e mplayer -slave -cache 96'

## Station Addresses ##
STATION[0]=""
STATION[1]="http://s18wm.castup.net/991791101-52.wmv" # 99ESC
STATION[2]="http://212.179.112.29/102fm"              # 102fm - Radio Tel-Aviv
STATION[3]="http://live.103.fm/103fm-low/"            # 103fm
STATION[4]="http://s18wm.castup.net/87382143-48.wmv"  # 106fm - Kol HaKampus
STATION[5]="http://213.8.143.164/audiomedia"          # 100fm - Radius
STATION[6]="http://213.8.138.13/gglz"                 # GalGalatz
STATION[7]="http://213.8.138.13/glz-stream"           # Gali-Tzahal
##

while [ 0 ]; do 
$DIALOG  --backtitle "Radio Station Selector" \
         --title "Choose your station" \
         --menu "Make your choice" 13 60 6 \
         1 "99ESC" \
         2 "102FM - Radio Tel-Aviv" \
         3 "103FM" \
         4 "106FM - Radio Kol-Hakampus" \
         5 "100FM - Radius" \
         6 "GalGalatz" \
         7 "Gali-Tzahal" \
         8 "Exit" 2> .tempfile
         RETURN=$?
         output=`cat .tempfile`
         rm -f .tempfile

if [ $RETURN = 1 ] || [ "$output" = "8" ]; then
  exit 0
fi

$PLAYCOMMAND  ${STATION[$output]} &  
PID=`ps ax | grep "$PLAYCOMMAND" | grep -v grep | awk '{print $1}'`

$DIALOG --backtitle "Radio Station Selector" \
        --title "Close Station?" \
        --yesno "Close Station?" 5 40

if [ $? = 0 ]; then
    kill $PID
fi
done

exit 0

                                                      
