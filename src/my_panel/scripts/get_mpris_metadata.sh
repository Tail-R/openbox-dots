#! /usr/bin/env bash

if mpris_metadata=$(playerctl metadata -f "{{xesam:title}} - {{xesam:artist}}" 2>/dev/null); then
    echo "♪ Now playing $mpris_metadata"
else
    echo "♪ No players found"
fi

