#!/bin/bash

#checks in the a there is a live connection to nordVPN - if not it connects
if [[ $(sudo nordvpn status) == *"Status: Connected"* ]]; then

echo "Already Connected"

else 

sleep 30

nordvpn connect sg188

echo "Connected to NORD"

sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
sudo iptables -A FORWARD -i tun0 -o wlan0 -m state --state RELATED,ESTABLISHED $
sudo iptables -A FORWARD -i wlan0 -o tun0 -j ACCEPT

echo "IP Tables Fixed"

fi

