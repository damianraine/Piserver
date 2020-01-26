#!/bin/bash

#checks in the a there is a live connection to nordVPN - if not it connects
if [[ $(sudo nordvpn status) == *"Status: Connected"* ]]; then

	echo "Already Connected"

	 if [[ ! $(pgrep -f deluge-web) ]]; then
                  deluge-web &
		  deluged
                  echo "deluge pushed live"
          fi
else

	kill $(pgrep -f deluge-web)
	echo "deluge killed"
	sleep 30

		nordvpn connect

		echo "Connected to NORD"

		sudo iptables -P INPUT ACCEPT
		sudo iptables -P OUTPUT ACCEPT
		sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
		sudo iptables -A FORWARD -i tun0 -o wlan0 -m state --state RELATED,ESTABLISHED $
		sudo iptables -A FORWARD -i wlan0 -o tun0 -j ACCEPT

		echo "IP Tables Fixed"

			if [[ ! $(pgrep -f deluge-web) ]]; then
			 	  deluge-web &
				  deluged
			echo "deluge pushed live"
			fi



fi

