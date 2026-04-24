#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    echo "󰎆 $artist - $title"
elif [ "$status" = "Paused" ]; then
    echo "󰏤 Pausado"
else
    echo ""
fi
