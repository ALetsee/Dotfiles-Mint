#!/bin/bash
export DISPLAY=:0

SINK="@DEFAULT_AUDIO_SINK@"

VOL_ACTUAL=$(wpctl get-volume "$SINK" | awk '{printf "%d", $2 * 100}')

NUEVO_VOL=$(zenity --scale \
    --title="Volumen" \
    --text=" Ajustar volumen" \
    --value="$VOL_ACTUAL" \
    --min-value=0 \
    --max-value=100 \
    --step=5 \
    --width=350 2>/dev/null)

if [ $? -eq 0 ] && [ -n "$NUEVO_VOL" ]; then
    wpctl set-volume "$SINK" "${NUEVO_VOL}%"
fi
