#! /usr/bin/env bash

capacity_file="/sys/class/power_supply/BAT0/capacity"

if [ ! -f $capacity_file ]; then
    echo err
fi


echo $(cat $capacity_file)%

