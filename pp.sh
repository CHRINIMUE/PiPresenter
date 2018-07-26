#!/bin/bash

PRESENTATION=/media/pi/FLASHDRIVE/current.odp
USB_PRESENT=0
APP_PID=0

if [ -e "$PRESENTATION" ]; then

  eche "Lade Präsentation vom USB-Stick"

  USB_PRESENT=1
  soffice --show "$PRESENTATION" --norestore &
  APP_PID=$!

  #Run loop to check if flashdrive is still present.
     if [ $USB_PRESENT -eq "1" ]; then

    	while [ $USB_PRESENT -eq "1"  ]; do
    	   sleep 10
       #If flashdrive is removed, continue and kill impress process.
    		if [ ! -e "$PRESENTATION" ]; then
    		  USB_PRESENT=0
    		fi
      done

      echo "USB-Stick entfernt, beende den Prozess: $APP_PID."
	    kill $APP_PID
	    echo ""

     fi

else
  # TODO: Check WIFI/LAN conection
  # TODO: Connect with Dropbox (automatic sync)

  echo "Lade Präsentation von GitHub"

  cd ~/Downloads/matchless
  git pull origin master

fi
