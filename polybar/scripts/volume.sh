#!/bin/bash

SINK="@DEFAULT_AUDIO_SINK@"
export DISPLAY=:0

get_vol() {
    wpctl get-volume "$SINK" | awk '{printf "%d", $2 * 100}'
}

is_muted() {
    wpctl get-volume "$SINK" | grep -q MUTED && echo "yes" || echo "no"
}

mostrar_popup() {
    local vol=$1
    local muted=$2

    if [ "$muted" = "yes" ]; then
        icono=""; texto="Silenciado"
    elif [ "$vol" -lt 30 ]; then
        icono=""; texto="Volumen: ${vol}%"
    elif [ "$vol" -lt 70 ]; then
        icono=""; texto="Volumen: ${vol}%"
    else
        icono=""; texto="Volumen: ${vol}%"
    fi

    pkill -f "zenity.*volume_popup" 2>/dev/null
    sleep 0.05

    zenity --title="volume_popup" \
           --progress \
           --text="$icono  $texto" \
           --value="$vol" \
           --width=300 \
           --no-cancel \
           --auto-close \
           --timeout=2 2>/dev/null &
}

case "$1" in
    up)
        wpctl set-volume "$SINK" 5%+
        mostrar_popup "$(get_vol)" "$(is_muted)"
        ;;
    down)
        wpctl set-volume "$SINK" 5%-
        mostrar_popup "$(get_vol)" "$(is_muted)"
        ;;
    mute)
        wpctl set-mute "$SINK" toggle
        mostrar_popup "$(get_vol)" "$(is_muted)"
        ;;
esac

# salida para polybar
if wpctl get-volume "$SINK" | grep -q MUTED; then
    echo "MUTED"
else
    echo "VOL $(get_vol)%"
fi
