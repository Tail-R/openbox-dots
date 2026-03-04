#! /usr/bin/env bash

# DEVICE:TYPE:STATE:CONNECTION
mapfile -t devices < <(nmcli -t -f DEVICE,TYPE,STATE,CONNECTION device)

ethernet_connected=false
wifi_ssid=""

for line in "${devices[@]}"; do
    IFS=":" read -r device type state connection <<< "$line"

    if [[ "$state" == "connected" ]]; then
        case "$type" in
            ethernet)
                ethernet_connected=true
                ;;
            wifi)
                wifi_ssid="$connection"
                ;;
        esac
    fi
done

if $ethernet_connected; then
    echo "Ethernet"
elif [[ -n "$wifi_ssid" ]]; then
    echo "$wifi_ssid"
else
    echo "offline"
fi

