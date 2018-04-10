#!/bin/sh
# set the battery charging thresholds to extend battery lifespan
modprobe tp_smapi
if [ -d "/sys/devices/platform/smapi" ]; then
    echo ${2:-90} > /sys/devices/platform/smapi/BAT${1:-0}/start_charge_thresh
    echo ${3:-95} > /sys/devices/platform/smapi/BAT${1:-0}/stop_charge_thresh
fi
