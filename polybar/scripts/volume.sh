#!/bin/bash

SINK="@DEFAULT_AUDIO_SINK@"

get_vol() {
    wpctl get-volume "$SINK" | awk '{printf "%d", $2 * 100}'
}

case "$1" in
    up) wpctl set-volume "$SINK" 5%+ ;;
    down) wpctl set-volume "$SINK" 5%- ;;
    mute) wpctl set-mute "$SINK" toggle ;;
esac

if wpctl get-volume "$SINK" | grep -q MUTED; then
    echo "MUTED"
else
    echo "VOL $(get_vol)%"
fi
